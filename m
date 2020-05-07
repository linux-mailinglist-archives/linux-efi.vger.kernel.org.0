Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AA21C8083
	for <lists+linux-efi@lfdr.de>; Thu,  7 May 2020 05:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgEGDbZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 May 2020 23:31:25 -0400
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:48660 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEGDbZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 6 May 2020 23:31:25 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 0473V11k016859; Thu, 7 May 2020 12:31:01 +0900
X-Iguazu-Qid: 2wHHidEfDYx9vilE7l
X-Iguazu-QSIG: v=2; s=0; t=1588822261; q=2wHHidEfDYx9vilE7l; m=6BRE7ZphtOumFxP7lJTmXQeCwrfuLxBXJdfkmmJii4E=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1113) id 0473UwSB030330;
        Thu, 7 May 2020 12:30:59 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 0473UwHP018679;
        Thu, 7 May 2020 12:30:58 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 0473Uv3g003704;
        Thu, 7 May 2020 12:30:58 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] efi: cper: Add support for printing Firmware Error Record Reference
References: <20200427085242.2380614-1-punit1.agrawal@toshiba.co.jp>
        <CAMj1kXFvaA0k7fZmWcWrjDEPu3rKUt2SM6y3pdROLQztjPKM=A@mail.gmail.com>
Date:   Thu, 07 May 2020 12:30:56 +0900
In-Reply-To: <CAMj1kXFvaA0k7fZmWcWrjDEPu3rKUt2SM6y3pdROLQztjPKM=A@mail.gmail.com>
        (Ard Biesheuvel's message of "Thu, 30 Apr 2020 14:08:08 +0200")
X-TSB-HOP: ON
Message-ID: <877dxos9ov.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

Ard Biesheuvel <ardb@kernel.org> writes:

> Hello Punit,
>
> On Mon, 27 Apr 2020 at 11:03, Punit Agrawal
> <punit1.agrawal@toshiba.co.jp> wrote:
>>
>> While debugging a boot failure, the following unknown error record was
>> seen in the boot logs.
>>
>>     <...>
>>     BERT: Error records from previous boot:
>>     [Hardware Error]: event severity: fatal
>>     [Hardware Error]:  Error 0, type: fatal
>>     [Hardware Error]:   section type: unknown, 81212a96-09ed-4996-9471-8d729c8e69ed
>>     [Hardware Error]:   section length: 0x290
>>     [Hardware Error]:   00000000: 00000001 00000000 00000000 00020002  ................
>>     [Hardware Error]:   00000010: 00020002 0000001f 00000320 00000000  ........ .......
>>     [Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
>>     [Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
>>     <...>
>>
>> On further investigation, it was found that the error record with
>> UUID (81212a96-09ed-4996-9471-8d729c8e69ed) has been defined in the
>> UEFI Specification at least since v2.4 and has recently had additional
>> fields defined in v2.7 Section N.2.10 Firmware Error Record Reference.
>>
>> Add support for parsing and printing the defined fields to give users
>> a chance to figure out what's went wrong.
>>
>> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: linux-acpi@vger.kernel.org
>> Cc: linux-efi@vger.kernel.org

[...]

>>  drivers/firmware/efi/cper.c | 49 +++++++++++++++++++++++++++++++++++++
>>  include/linux/cper.h        | 11 +++++++++
>>  2 files changed, 60 insertions(+)
>>
>> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
>> index 9d2512913d25..153b95257e23 100644
>> --- a/drivers/firmware/efi/cper.c
>> +++ b/drivers/firmware/efi/cper.c
>> @@ -407,6 +407,46 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
>>         }
>>  }
>>
>> +static const char * const fw_err_rec_type_strs[] = {
>> +       "IPF SAL Error Record",
>> +       "SOC Firmware Error Record Type1 (Legacy CrashLog Support)",
>> +       "SOC Firmware Error Record Type2",
>> +};
>> +
>> +static void cper_print_fw_err(const char *pfx,
>> +                             struct acpi_hest_generic_data *gdata,
>> +                             const struct cper_sec_fw_err_rec_ref *fw_err)
>> +{
>> +       void *buf = acpi_hest_get_payload(gdata);
>> +       u32 offset, length = gdata->error_data_length;
>> +
>> +       printk("%s""Firmware Error Record Type: %s\n", pfx,
>> +              fw_err->record_type < ARRAY_SIZE(fw_err_rec_type_strs) ?
>> +              fw_err_rec_type_strs[fw_err->record_type] : "unknown");
>> +
>> +       /* Record Type based on UEFI 2.7 */
>> +       if (fw_err->revision == 0)
>> +               printk("%s""Record Identifier: %08llx\n", pfx,
>> +                      fw_err->record_identifier);
>> +       else if (fw_err->revision == 2)
>> +               printk("%s""Record Identifier: %pUl\n", pfx,
>> +                      &fw_err->record_identifier_guid);
>> +
>
> Please use {} for multi-line statements between the ifs
>
>> +       if (fw_err->revision == 0)
>> +               offset = offsetof(struct cper_sec_fw_err_rec_ref,
>> +                                 record_identifier_guid);
>> +       else if (fw_err->revision == 1)
>> +               offset = offsetof(struct cper_sec_fw_err_rec_ref,
>> +                                 record_identifier);
>> +       else
>> +               offset = sizeof(*fw_err);
>> +
>
> This logic is slightly confusing, so it could do with a comment
> regarding which part of the structure is being dumped and why.
>
>
>> +       buf += offset;
>> +       length -= offset;
>> +
>> +       print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, buf, length, true);
>> +}
>> +
>>  static void cper_print_tstamp(const char *pfx,
>>                                    struct acpi_hest_generic_data_v300 *gdata)
>>  {
>> @@ -494,6 +534,15 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
>>                 else
>>                         goto err_section_too_small;
>>  #endif
>> +       } else if (guid_equal(sec_type, &CPER_SEC_FW_ERR_REC_REF)) {
>> +               struct cper_sec_fw_err_rec_ref *fw_err = acpi_hest_get_payload(gdata);
>> +
>> +               printk("%ssection_type: Firmware Error Record Reference\n",
>> +                      newpfx);
>> +               if (gdata->error_data_length >= sizeof(*fw_err))
>> +                       cper_print_fw_err(newpfx, gdata, fw_err);
>
> This doesn't work for revision 0 structures unless they happen to have
> some trailing data, which is not necessarily the case, right?

Good catch. I will re-work this to avoid skipping revision 0 record.

>> +               else
>> +                       goto err_section_too_small;
>>         } else {
>>                 const void *err = acpi_hest_get_payload(gdata);
>>
>> diff --git a/include/linux/cper.h b/include/linux/cper.h
>> index 4f005d95ce88..5cb57e69df70 100644
>> --- a/include/linux/cper.h
>> +++ b/include/linux/cper.h
>> @@ -521,6 +521,17 @@ struct cper_sec_pcie {
>>         u8      aer_info[96];
>>  };
>>
>> +/* Firmware Error Record Reference, UEFI v2.7 sec N.2.10  */
>> +struct cper_sec_fw_err_rec_ref {
>> +       u8 record_type;
>> +       union {
>> +               u8 revision;
>> +               u8 reserved[7];
>> +       };
>
> Even though the spec is slightly silly here, I think we can avoid the
> union, and just have
>
>   u8 record_type;
>   u8 revision;
>   u8 reserved[6];
>
> as the leading fields.

That's a better interpretation of the spec. I will follow your
suggestion and send a new version incorporating this and other
suggestions.

Thanks for taking a look.

Punit

[...]

