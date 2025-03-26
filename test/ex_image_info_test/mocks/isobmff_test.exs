defmodule ExImageInfoTest.Mocks.ISOBMFFTest do
  @moduledoc "HEIF, HEIC and AVIF tests using binary mocks."
  use ExUnit.Case, async: true

  import ExImageInfo

  setup_all do
    images = %{
      "heic" => <<
        0x00000018::32,
        "ftyp", #0x66747970::32
        "heic", # 0x68656963::32,
        0x00000000::32,
        0x68656963::32, 0x6D696631::32,
        # first box (ftyp)
        0x000001EC::32, 0x6D657461::32,
        0x00000000::32, 0x00000021::32, 0x68646C72::32, 0x00000000::32,
        0x00000000::32, 0x70696374::32, 0x00000000::32, 0x00000000::32,
        0x00000000::32, 0x00000000::32, 0x2464696E::32, 0x66000000::32,
        0x1C647265::32, 0x66000000::32, 0x00000000::32, 0x01000000::32,
        0x0C75726C::32, 0x20000000::32, 0x01000000::32, 0x0E706974::32, # "pit"
        0x6D000000::32, 0x00000100::32, # end of pitm box at 01
        0x00003869::32, 0x696E6600::32,
        0x00000000::32, 0x02000000::32, 0x15696E66::32, 0x65020000::32,
        0x00000100::32, 0x00687663::32, 0x31000000::32, 0x0015696E::32,
        0x66650200::32, 0x00010002::32, 0x00004578::32, 0x69660000::32,
        0x00001A69::32, 0x72656600::32, 0x00000000::32, 0x00000E63::32,
        0x64736300::32, 0x02000100::32, 0x01000001::32, 0x0F697072::32,
        0x70000000::32, 0xED697063::32, 0x6F000000::32, 0x13636F6C::32,
        0x726E636C::32, 0x78000200::32, 0x02000680::32, 0x0000000C::32,
        0x636C6C69::32, 0x00CB0040::32, 0x00000014::32, 0x69737065::32,
        0x00000000::32, 0x0000000E::32, 0x00000004::32, 0x00000028::32,
        0x636C6170::32, 0x0000000D::32, 0x00000001::32, 0x00000004::32,
        0x00000001::32, 0xFFC00000::32, 0x00800000::32, 0x00000000::32,
        0x00000001::32, 0x00000009::32, 0x69726F74::32, 0x00000000::32,
        0x10706978::32, 0x69000000::32, 0x00030808::32, 0x08000000::32,
        0x71687663::32, 0x43010370::32, 0x000000B0::32, 0x00000000::32,
        0x001EF000::32, 0xFCFDF8F8::32, 0x00000B03::32, 0xA0000100::32,
        0x1740010C::32, 0x01FFFF03::32, 0x70000003::32, 0x00B00000::32,
        0x03000003::32, 0x001E7024::32, 0xA1000100::32, 0x23420101::32,
        0x03700000::32, 0x0300B000::32, 0x00030000::32, 0x03001EA0::32,
        0x142041C0::32, 0x950FE21E::32, 0xE45954DC::32, 0x08081802::32,
        0xA2000100::32, 0x094401C0::32, 0x6172C844::32, 0x53640000::32,
        0x001A6970::32, 0x6D610000::32, 0x00000000::32, 0x00010001::32,
        0x07810203::32, 0x84850687::32, 0x0000002C::32, 0x696C6F63::32,
        0x00000000::32, 0x44000002::32, 0x00010000::32, 0x00010000::32,
        0x02600000::32, 0x008A0002::32, 0x00000001::32, 0x00000214::32,
        0x0000004C::32, 0x00000001::32, 0x6D646174::32, 0x00000000::32,
        0x000000E6::32, 0x00000006::32, 0x45786966::32, 0x00004D4D::32,
        0x002A0000::32, 0x00080003::32, 0x01120003::32, 0x00000001::32,
        0x00010000::32, 0x011A0005::32, 0x00000001::32, 0x00000032::32,
        0x011B0005::32, 0x00000001::32, 0x0000003A::32, 0x00000000::32,
        0x00000048::32, 0x00000001::32, 0x00000048::32, 0x00000001::32,
        0x00000086::32, 0x2801AFA3::32, 0xF88010D4::32, 0x8A8D7FF9::32,
        0x7431858E::32, 0x8ADC0404::32, 0x77A2E617::32, 0x3190E99C::32,
        0x079BFFAF::32, 0x302F99D8::32, 0xC0E3D4CD::32, 0x121DD65D::32,
        0xF49D5B5E::32, 0xEA51213B::32, 0xFFFFA497::32, 0x8427762A::32,
        0x77DE4B45::32, 0xAA3A060E::32, 0x621C6A2E::32, 0xE4C644FA::32,
        0x06CF7E5F::32, 0x790A0E5D::32, 0x0552E88B::32, 0x7F8006A3::32,
        0x047D3D16::32, 0x8F5D6CFB::32, 0x3DDE8AAF::32, 0x5CA393CE::32,
        0x908DD2BB::32, 0xE38B7FB6::32, 0x0AC6C93F::32, 0xBB248057::32,
        0x0C9A2036::32, 0x2FA20851::32, 0xD36E::32
      >>,
      "heic-ispe" => <<
        0x00000018::32,
        "ftyp", #0x66747970::32
        "heic", # 0x68656963::32,
        0x00000000::32,
        0x68656963::32, 0x6D696631::32,
        # first box (ftyp)
        0x000001EC::32, 0x6D657461::32,
        0x00000000::32, 0x00000021::32, 0x68646C72::32, 0x00000000::32,
        0x00000000::32, 0x70696374::32, 0x00000000::32, 0x00000000::32,
        0x00000000::32, 0x00000000::32, 0x2464696E::32, 0x66000000::32,
        0x1C647265::32, 0x66000000::32, 0x00000000::32, 0x01000000::32,
        0x0C75726C::32, 0x20000000::32, 0x01000000::32, 0x0E706974::32,
        0x6D000000::32, 0x00000100::32, 0x00003869::32, 0x696E6600::32,
        0x00000000::32, 0x02000000::32, 0x15696E66::32, 0x65020000::32,
        0x00000100::32, 0x00687663::32, 0x31000000::32, 0x0015696E::32,
        0x66650200::32, 0x00010002::32, 0x00004578::32, 0x69660000::32,
        0x00001A69::32, 0x72656600::32, 0x00000000::32, 0x00000E63::32,
        0x64736300::32, 0x02000100::32, 0x01000001::32, 0x0F697072::32,
        0x70000000::32, 0xED697063::32, 0x6F000000::32, 0x13636F6C::32,
        0x726E636C::32, 0x78000200::32, 0x02000680::32, 0x0000000C::32,
        0x636C6C69::32, 0x00CB0040::32, 0x00000004::32, "ispe",
        # 0x00000000::32, 0x0000000E::32, 0x00000004::32, 0x00000028::32,
      >>,
      "heic-extended-size-and-wrong-primary-box" => <<
        # tried using extended size for the first box, and it does not work
        # because the size(64) overlaps with the "brand" in the first 4 bytes
        0x00000018::32,
        "ftyp", #0x66747970::32
        "heic", # 0x68656963::32,
        # it seems it cannot be here the extended size
        # 0x0000000000000018::size(64),
        0x00000000::32,
        0x68656963::32, 0x6D696631::32,
        # first box done (ftyp)
        0x000001EC::32, 0x6D657461::32,
        0x00000000::32, 0x00000021::32, "hdlr", 0x00000000::32,
        0x00000000::32, "pict", 0x00000000::32, 0x00000000::32,
        0x00000000::32, 0x00000000::32, 0x2464696E::32, 0x66000000::32,
        0x1C647265::32, 0x66000000::32, 0x00000000::32, 0x01000000::32,
        0x0C75726C::32, 0x20000000::32, 0x01::8,
        # starts pitm box
        0x00000001::32, # 1 == extended size
        "pitm", # 0x7069746D::32,
        (4 + 4 + 8 + 6)::64, # extended size, has to read until end of pitm
        0x000000::24, 0x0000::16, 2::8, # changing the primary_box to 2 (will be invalid)
        # ends pitm box
        0x00::8, 0x00003869::32, 0x696E6600::32,
        0x00000000::32, 0x02000000::32, 0x15696E66::32, 0x65020000::32,
        0x00000100::32, 0x00687663::32, 0x31000000::32, 0x0015696E::32,
        0x66650200::32, 0x00010002::32, 0x00004578::32, 0x69660000::32,
        0x00001A69::32, 0x72656600::32, 0x00000000::32, 0x00000E63::32,
        0x64736300::32, 0x02000100::32, 0x01000001::32, 0x0F697072::32,
        0x70000000::32, 0xED697063::32, 0x6F000000::32, 0x13636F6C::32,
        0x726E636C::32, 0x78000200::32, 0x02000680::32, 0x0000000C::32,
        0x636C6C69::32, 0x00CB0040::32, 0x00000014::32, 0x69737065::32,
        0x00000000::32, 0x0000000E::32, 0x00000004::32, 0x00000028::32,
        0x636C6170::32, 0x0000000D::32, 0x00000001::32, 0x00000004::32,
        0x00000001::32, 0xFFC00000::32, 0x00800000::32, 0x00000000::32,
        0x00000001::32, 0x00000009::32, 0x69726F74::32, 0x00000000::32,
        0x10706978::32, 0x69000000::32, 0x00030808::32, 0x08000000::32,
        0x71687663::32, 0x43010370::32, 0x000000B0::32, 0x00000000::32,
        0x001EF000::32, 0xFCFDF8F8::32, 0x00000B03::32, 0xA0000100::32,
        0x1740010C::32, 0x01FFFF03::32, 0x70000003::32, 0x00B00000::32,
        0x03000003::32, 0x001E7024::32, 0xA1000100::32, 0x23420101::32,
        0x03700000::32, 0x0300B000::32, 0x00030000::32, 0x03001EA0::32,
        0x142041C0::32, 0x950FE21E::32, 0xE45954DC::32, 0x08081802::32,
        0xA2000100::32, 0x094401C0::32, 0x6172C844::32, 0x53640000::32,
        0x001A6970::32, 0x6D610000::32, 0x00000000::32, 0x00010001::32,
        0x07810203::32, 0x84850687::32, 0x0000002C::32, 0x696C6F63::32,
        0x00000000::32, 0x44000002::32, 0x00010000::32, 0x00010000::32,
        0x02600000::32, 0x008A0002::32, 0x00000001::32, 0x00000214::32,
        0x0000004C::32, 0x00000001::32, 0x6D646174::32, 0x00000000::32,
        0x000000E6::32, 0x00000006::32, 0x45786966::32, 0x00004D4D::32,
        0x002A0000::32, 0x00080003::32, 0x01120003::32, 0x00000001::32,
        0x00010000::32, 0x011A0005::32, 0x00000001::32, 0x00000032::32,
        0x011B0005::32, 0x00000001::32, 0x0000003A::32, 0x00000000::32,
        0x00000048::32, 0x00000001::32, 0x00000048::32, 0x00000001::32,
        0x00000086::32, 0x2801AFA3::32, 0xF88010D4::32, 0x8A8D7FF9::32,
        0x7431858E::32, 0x8ADC0404::32, 0x77A2E617::32, 0x3190E99C::32,
        0x079BFFAF::32, 0x302F99D8::32, 0xC0E3D4CD::32, 0x121DD65D::32,
        0xF49D5B5E::32, 0xEA51213B::32, 0xFFFFA497::32, 0x8427762A::32,
        0x77DE4B45::32, 0xAA3A060E::32, 0x621C6A2E::32, 0xE4C644FA::32,
        0x06CF7E5F::32, 0x790A0E5D::32, 0x0552E88B::32, 0x7F8006A3::32,
        0x047D3D16::32, 0x8F5D6CFB::32, 0x3DDE8AAF::32, 0x5CA393CE::32,
        0x908DD2BB::32, 0xE38B7FB6::32, 0x0AC6C93F::32, 0xBB248057::32,
        0x0C9A2036::32, 0x2FA20851::32, 0xD36E::32
      >>,
      "heic-hdlr-1" => <<
        # tried using extended size for the first box, and it does not work
        # because the size(64) overlaps with the "brand" in the first 4 bytes
        0x00000018::32,
        "ftyp", #0x66747970::32
        "heic", # 0x68656963::32,
        # it seems it cannot be here the extended size
        # 0x0000000000000018::size(64),
        0x00000000::32,
        0x68656963::32, 0x6D696631::32,
        # first box done (ftyp)
        0x000001EC::32, 0x6D657461::32,
        0x00000000::32, 0x00000021::32, "hdlr", 0x00000000::32,
        0x00000000::32, "____", # no "pict"
        0x00000000::32, 0x00000000::32,
        0x00000000::32, 0x00000000::32, 0x2464696E::32, 0x66000000::32,
        0x1C647265::32, 0x66000000::32, 0x00000000::32, 0x01000000::32,
        0x0C75726C::32, 0x20000000::32, 0x01::8,
        # starts pitm box
        0x00000001::32, # 1 == extended size
        "pitm", # 0x7069746D::32,
        (4 + 4 + 8 + 6)::64, # extended size, has to read until end of pitm
        0x000000::24, 0x0000::16, 1::8, # valid primary_box
        # ends pitm box
        # When supported, continue placing the contents of the above image:
        # 0x00::8, 0x00003869::32, 0x696E6600::32, ...
      >>,
      "heic-hdlr-2" => <<
        # tried using extended size for the first box, and it does not work
        # because the size(64) overlaps with the "brand" in the first 4 bytes
        0x00000018::32,
        "ftyp", #0x66747970::32
        "heic", # 0x68656963::32,
        # it seems it cannot be here the extended size
        # 0x0000000000000018::size(64),
        0x00000000::32,
        0x68656963::32, 0x6D696631::32,
        # first box done (ftyp)
        0x000001EC::32, 0x6D657461::32,
        0x00000000::32, 0x00000009::32, "hdlr", 0x00000000::32,
        0x00000000::32, "____", # no "pict"
        0x00000000::32, 0x00000000::32,
        0x00000000::32, 0x00000000::32, 0x2464696E::32, 0x66000000::32,
        0x1C647265::32, 0x66000000::32, 0x00000000::32, 0x01000000::32,
        0x0C75726C::32, 0x20000000::32, 0x01::8,
        # starts pitm box
        0x00000001::32, # 1 == extended size
        "pitm", # 0x7069746D::32,
        (4 + 4 + 8 + 6)::64, # extended size, has to read until end of pitm
        0x000000::24, 0x0000::16, 1::8, # valid primary_box
        # ends pitm box
        # 0x00::8, 0x00003869::32, 0x696E6600::32, ...
      >>,
      "heic-jxlc" => <<
        # tried using extended size for the first box, and it does not work
        # because the size(64) overlaps with the "brand" in the first 4 bytes
        0x00000018::32,
        "ftyp", #0x66747970::32
        "heic", # 0x68656963::32,
        # it seems it cannot be here the extended size
        # 0x0000000000000018::size(64),
        0x00000000::32,
        0x68656963::32, 0x6D696631::32,
        # first box done (ftyp)
        0x000001EC::32, 0x6D657461::32,
        0x00000000::32, 0x00000009::32, "jxlc", 0x00000000::32
      >>,
      "heic-meta" => <<
        # tried using extended size for the first box, and it does not work
        # because the size(64) overlaps with the "brand" in the first 4 bytes
        0x00000018::32,
        "ftyp", #0x66747970::32
        "heic", # 0x68656963::32,
        # it seems it cannot be here the extended size
        # 0x0000000000000018::size(64),
        0x00000000::32,
        0x68656963::32, 0x6D696631::32,
        # first box done (ftyp)
        0x00000002::32, # meta size < 4
        "meta",
        0x00000000::32, 0x00000009::32
      >>,
      "heif" => <<
        0x00000018::32, "ftyp", "mif1", 0x00000000::32,
        0x6D696631::32, 0x68656963::32, 0x000001FE::32, 0x6D657461::32,
        0x00000000::32, 0x00000021::32, 0x68646C72::32, 0x00000000::32,
        0x00000000::32, 0x70696374::32, 0x00000000::32, 0x00000000::32,
        0x00000000::32, 0x00000000::32, 0x0E706974::32, 0x6D000000::32,
        0x0003EA00::32, 0x00003469::32, 0x6C6F6300::32, 0x00000044::32,
        0x40000203::32, 0xEA000000::32, 0x00021600::32, 0x01000000::32,
        0x0800046A::32, 0x8003ED00::32, 0x00000002::32, 0x16000100::32,
        0x046A8800::32, 0x000E4A00::32, 0x00004C69::32, 0x696E6600::32,
        0x00000000::32, 0x02000000::32, 0x1F696E66::32, 0x65020000::32,
        0x0003EA00::32, 0x00687663::32, 0x31484556::32, 0x4320496D::32,
        0x61676500::32, 0x0000001F::32, 0x696E6665::32, 0x02000000::32,
        0x03ED0000::32, 0x68766331::32, 0x48455643::32, 0x20496D61::32,
        0x67650000::32, 0x00001A69::32, 0x72656600::32, 0x00000000::32,
        0x00000E74::32, 0x686D6203::32, 0xED000103::32, 0xEA000001::32,
        0x29697072::32, 0x70000001::32, 0x07697063::32, 0x6F000000::32,
        0x6C687663::32, 0x43010160::32, 0x00000000::32, 0x00000000::32,
        0x00BAF000::32, 0xFCFDF8F8::32, 0x00000F03::32, 0xA0000100::32,
        0x1840010C::32, 0x01FFFF01::32, 0x60000003::32, 0x00000300::32,
        0x00030000::32, 0x0300BAF0::32, 0x24A10001::32, 0x001F4201::32,
        0x01016000::32, 0x00030000::32, 0x03000003::32, 0x00000300::32,
        0xBAA002D0::32, 0x803C1FE5::32, 0xF9246D9E::32, 0xD9A20001::32,
        0x00074401::32, 0xC1909581::32, 0x12000000::32, 0x14697370::32,
        0x65000000::32, 0x00000000::32, 0x0D000000::32, 0x04000000::32,
        0x6B687663::32, 0x43010160::32, 0x00000000::32, 0x00000000::32,
        0x00BAF000::32, 0xFCFDF8F8::32, 0x00000F03::32, 0xA0000100::32,
        0x1840010C::32, 0x01FFFF01::32, 0x60000003::32, 0x00000300::32,
        0x00030000::32, 0x0300BAF0::32, 0x24A10001::32, 0x001E4201::32,
        0x01016000::32, 0x00030000::32, 0x03000003::32, 0x00000300::32,
        0xBAA01E20::32, 0x287F97E4::32, 0x91B67B64::32, 0xA2000100::32,
        0x074401C1::32, 0x90958112::32, 0x00000014::32, 0x69737065::32,
        0x00000000::32, 0x000000F0::32, 0x000000A0::32, 0x0000001A::32,
        0x69706D61::32, 0x00000000::32, 0x00000002::32, 0x03EA0281::32,
        0x0203ED02::32, 0x83040004::32, 0x78D2::32
      >>,
      "avif" => <<
        0x0000001C::32, "ftyp", "avif", 0x00000000::32,
        0x61766966::32, 0x6D696631::32, 0x6D696166::32, 0x000000EA::32,
        0x6D657461::32, 0x00000000::32, 0x00000021::32, 0x68646C72::32,
        0x00000000::32, 0x00000000::32, 0x70696374::32, 0x00000000::32,
        0x00000000::32, 0x00000000::32, 0x00000000::32, 0x0E706974::32,
        0x6D000000::32, 0x00000100::32, 0x00002269::32, 0x6C6F6300::32,
        0x00000044::32, 0x40000100::32, 0x01000000::32, 0x00010E00::32,
        0x01000000::32, 0x00000003::32, 0x0F000000::32, 0x2369696E::32,
        0x66000000::32, 0x00000100::32, 0x00001569::32, 0x6E666502::32,
        0x00000000::32, 0x01000061::32, 0x76303100::32, 0x0000006A::32,
        0x69707270::32, 0x0000004B::32, 0x6970636F::32, 0x0000000C::32,
        0x61763143::32, 0x81000C00::32, 0x00000013::32, 0x636F6C72::32,
        0x6E636C78::32, 0x0001000D::32, 0x00068000::32, 0x00001469::32,
        0x73706500::32, 0x00000000::32, 0x00008200::32, 0x00002A00::32,
        0x00001070::32, 0x69786900::32, 0x00000003::32, 0x08080800::32,
        0x00001769::32, 0x706D6100::32, 0x00000000::32, 0x00000100::32,
        0x01048102::32, 0x03040000::32, 0x03::32
      >>,
      "truncated-not-readable" => <<
        0x0000001C::32, "ftyp", "avif", 0x00000000::32,
        0x61766966::32, 0x6D696631::32, 0x6D696166::32, 12::32, # truncated here
        "meta", 0x00000000::32, 0x00000021::32, 0x68646C72::32,
        0x00000000::32, 0x00000000::32, 0x70696374::32, 0x00000000::32,
        0x00000000::32, 0x00000000::32, 0x00000000::32, 0x0E706974::32,
        0x6D000000::32, 0x00000100::32, 0x00002269::32, 0x6C6F6300::32,
        0x00000044::32, 0x40000100::32, 0x01000000::32, 0x00010E00::32,
        0x01000000::32, 0x00000003::32, 0x0F000000::32, 0x2369696E::32,
        0x66000000::32, 0x00000100::32, 0x00001569::32, 0x6E666502::32,
        0x00000000::32, 0x01000061::32, 0x76303100::32, 0x0000006A::32,
        0x69707270::32, 0x0000004B::32, 0x6970636F::32, 0x0000000C::32,
        0x61763143::32, 0x81000C00::32, 0x00000013::32, 0x636F6C72::32,
        0x6E636C78::32, 0x0001000D::32, 0x00068000::32, 0x00001469::32,
        0x73706500::32, 0x00000000::32, 0x00008200::32, 0x00002A00::32,
        0x00001070::32, 0x69786900::32, 0x00000003::32, 0x08080800::32,
        0x00001769::32, 0x706D6100::32, 0x00000000::32, 0x00000100::32,
        0x01048102::32, 0x03040000::32, 0x03::32
      >>
    }

    {:ok, images}
  end

  test "force - xx heif/heic binary mock - #seems? #type #info (unimplemented regions)",
       images do
    # hdlr box w/o pict
    image = images["truncated-not-readable"]
    # assert seems?(image, :heic) == true
    # assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :avif) == nil
  end

  test "force - heif/heic binary mock - #seems? #type #info (unimplemented regions)",
       images do
    # hdlr box w/o pict
    image = images["heic-hdlr-1"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == nil

    # hdlr box size < 12
    image = images["heic-hdlr-2"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == nil

    # ispe box w/o width and height
    image = images["heic-ispe"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == nil

    # unknown box type
    image = images["heic-jxlc"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == nil

    # meta size < 4
    image = images["heic-meta"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == nil
  end

  test "force - heif/heic binary mock - #seems? #type #info (edge cases)", images do
    # not matching primary box + extended size
    image = images["heic-extended-size-and-wrong-primary-box"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == nil
  end

  test "force - heif/heic/avif binary mock - #seems? #type #info", images do
    image = images["heic"]
    assert seems?(image, :heic) == true
    assert type(image, :heic) == {"image/heic", "HEIC"}
    assert info(image, :heic) == {"image/heic", 14, 4, "HEIC"}

    image = images["heif"]
    assert seems?(image, :heif) == true
    assert type(image, :heif) == {"image/heif", "HEIF"}
    assert info(image, :heif) == {"image/heif", 13, 4, "HEIF"}

    image = images["avif"]
    assert seems?(image, :avif) == true
    assert type(image, :avif) == {"image/avif", "AVIF"}
    assert info(image, :avif) == {"image/avif", 130, 42, "AVIF"}
  end

  test "guess - heif/heic/avif binary mock - #seems? #type #info", images do
    image = images["heic"]
    assert seems?(image) == :heic
    assert type(image) == {"image/heic", "HEIC"}
    assert info(image) == {"image/heic", 14, 4, "HEIC"}

    image = images["heif"]
    assert seems?(image) == :heif
    assert type(image) == {"image/heif", "HEIF"}
    assert info(image) == {"image/heif", 13, 4, "HEIF"}

    image = images["avif"]
    assert seems?(image) == :avif
    assert type(image) == {"image/avif", "AVIF"}
    assert info(image) == {"image/avif", 130, 42, "AVIF"}
  end

  malformed_cases = [
    read_box_header: 270,
    ftyp: 12,
    hdlr: 60,
    ispe: 256,
    pitm: 114,
    skippable: 77
  ]

  for {location, len} <- malformed_cases do
    test "force - heif/heic binary mock - #seems? #type #info - malformed binary in #{location} when truncating 0..#{len}",
         context do
      %{"heic" => image, :test => test_name} = context

      {num, ""} =
        test_name
        |> Atom.to_string()
        |> String.split("..", trim: true)
        |> Enum.map(&String.trim(&1))
        |> List.last()
        |> Integer.parse()

      image_truncated = binary_part(image, 0, num)
      assert seems?(image_truncated) == :heic
      assert type(image_truncated) == {"image/heic", "HEIC"}
      assert info(image_truncated, :heic) == nil
    end

    test "guess - heif/heic binary mock - #seems? #type #info - malformed binary in #{location} when truncating 0..#{len}",
         context do
      %{"heic" => image, :test => test_name} = context

      {num, ""} =
        test_name
        |> Atom.to_string()
        |> String.split("..", trim: true)
        |> Enum.map(&String.trim(&1))
        |> List.last()
        |> Integer.parse()

      image_truncated = binary_part(image, 0, num)
      assert seems?(image_truncated) == :heic
      assert type(image_truncated) == {"image/heic", "HEIC"}
      assert info(image_truncated) == nil
    end
  end
end