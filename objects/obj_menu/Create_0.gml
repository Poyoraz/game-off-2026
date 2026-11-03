Major = new MajorGUI()
Major.m_font = fnCascadiaCode

screen_size = new Vector2(wid, ht)

Major.Setup(screen_size)

menu_object.page.render(Major, global.MAJORGUI_MAIN_CANVAS)

queued_for_rerender_on_room_enter = false

_ReadyDraw = method(Major, ReadyDraw)

modals = []

queued_unloads = 0