require "test_helper"

class ModalComponentTest < Minitest::Test
  include Polaris::ComponentTestHelpers

  def test_basic_modal
    render_inline(Polaris::ModalComponent.new(title: "Title")) do |modal|
      modal.primary_action { "Primary" }
      modal.secondary_action { "Secondary" }

      "Content"
    end

    assert_selector ".Polaris-Modal-Dialog__Container", visible: :all do
      assert_selector ".Polaris-Modal-Dialog > .Polaris-Modal-Dialog__Modal", visible: :all do
        assert_selector ".Polaris-Modal-Header", visible: :all do
          assert_selector ".Polaris-Modal-Header__Title > h2", visible: :all, text: "Title"
          assert_selector "button.Polaris-Modal-CloseButton > .Polaris-Icon"
        end
        assert_selector ".Polaris-Modal__BodyWrapper > .Polaris-Modal__Body.Polaris-Scrollable", visible: :all do
          assert_selector ".Polaris-Modal-Section", visible: :all, text: "Content"
        end
        assert_selector ".Polaris-Modal-Footer > .Polaris-Modal-Footer__FooterContent", visible: :all do
          assert_selector ".Polaris-Stack .Polaris-Button--primary", visible: :all, text: "Primary"
          assert_selector ".Polaris-Stack .Polaris-Button", visible: :all, text: "Secondary"
        end
      end
    end
  end

  def test_large_modal
    render_inline(Polaris::ModalComponent.new(title: "Title", large: true)) do |modal|
      "Content"
    end

    assert_selector ".Polaris-Modal-Dialog__Modal.Polaris-Modal-Dialog--sizeLarge", visible: :all
  end

  def test_large_small
    render_inline(Polaris::ModalComponent.new(title: "Title", small: true)) do |modal|
      "Content"
    end

    assert_selector ".Polaris-Modal-Dialog__Modal.Polaris-Modal-Dialog--sizeSmall", visible: :all
  end

  def test_limit_height
    render_inline(Polaris::ModalComponent.new(title: "Title", limit_height: true)) do |modal|
      "Content"
    end

    assert_selector ".Polaris-Modal-Dialog__Modal.Polaris-Modal-Dialog--limitHeight", visible: :all
  end

  def test_custom_close_button
    render_inline(Polaris::ModalComponent.new(title: "Title")) do |modal|
      modal.close_button(data: {custom_close: true}) { "Primary" }
      "Content"
    end

    assert_selector ".Polaris-Modal-Header > button[data-custom-close]", visible: :all
  end

  def test_multiple_sections
    render_inline(Polaris::ModalComponent.new(title: "Title")) do |modal|
      modal.section { "Section1" }
      modal.section { "Section2" }
    end

    assert_selector ".Polaris-Modal__BodyWrapper", visible: :all do
      assert_selector ".Polaris-Modal-Section", visible: :all, count: 2
      assert_selector ".Polaris-Modal-Section:nth-of-type(1)", visible: :all, text: "Section1"
      assert_selector ".Polaris-Modal-Section:nth-of-type(2)", visible: :all, text: "Section2"
    end
  end

  def test_without_title
    render_inline(Polaris::ModalComponent.new(title: false)) do |modal|
      "Content"
    end

    assert_selector ".Polaris-Modal-Header--titleHidden"
  end
end
