Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BF61BF7E8
	for <lists+linux-efi@lfdr.de>; Thu, 30 Apr 2020 14:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgD3MIZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Apr 2020 08:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbgD3MIV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 30 Apr 2020 08:08:21 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBEA820870;
        Thu, 30 Apr 2020 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588248499;
        bh=YyBLLWLpFjb7adMOuHtpkyiUlOgZgh/648rPnhjJOGY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sEX6q1UkT3HN9nlruFzlJJZNe9xdFvRODgAJawo+DfQqdzQ/fU12etNbcah/xTMX5
         xH1TbyVgFPQgs8i3GCB30Oz7vhLSj949dh0ULxtLorhAP6kFQ8xYjk+DIBLctKpMqW
         g8IGHzbVHjQqclIKcxk1HO2GgW8DsmQndBLU/BJg=
Received: by mail-io1-f41.google.com with SMTP id b12so1156171ion.8;
        Thu, 30 Apr 2020 05:08:19 -0700 (PDT)
X-Gm-Message-State: AGi0PuY4CCfd6hW1W1WAzyyVKoc1t570gga/NG8BVbzBAPton/G8g//f
        scw332gyPXbbLLyNdOqdShUN2s1u2LI1TcxddEM=
X-Google-Smtp-Source: APiQypKe0inqW34wBlLScBwFhjM3coQkERVQcuEwJdUDy41iqDLa5MVALB/56aNH0jT/ZkFBLYzUNbyfwy+VnBdkxaY=
X-Received: by 2002:a02:6a1e:: with SMTP id l30mr807847jac.98.1588248499222;
 Thu, 30 Apr 2020 05:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200427085242.2380614-1-punit1.agrawal@toshiba.co.jp>
In-Reply-To: <20200427085242.2380614-1-punit1.agrawal@toshiba.co.jp>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 30 Apr 2020 14:08:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFvaA0k7fZmWcWrjDEPu3rKUt2SM6y3pdROLQztjPKM=A@mail.gmail.com>
Message-ID: <CAMj1kXFvaA0k7fZmWcWrjDEPu3rKUt2SM6y3pdROLQztjPKM=A@mail.gmail.com>
Subject: Re: [PATCH] efi: cper: Add support for printing Firmware Error Record Reference
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Punit,

On Mon, 27 Apr 2020 at 11:03, Punit Agrawal
<punit1.agrawal@toshiba.co.jp> wrote:
>
> While debugging a boot failure, the following unknown error record was
> seen in the boot logs.
>
>     <...>
>     BERT: Error records from previous boot:
>     [Hardware Error]: event severity: fatal
>     [Hardware Error]:  Error 0, type: fatal
>     [Hardware Error]:   section type: unknown, 81212a96-09ed-4996-9471-8d729c8e69ed
>     [Hardware Error]:   section length: 0x290
>     [Hardware Error]:   00000000: 00000001 00000000 00000000 00020002  ................
>     [Hardware Error]:   00000010: 00020002 0000001f 00000320 00000000  ........ .......
>     [Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
>     [Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
>     <...>
>
> On further investigation, it was found that the error record with
> UUID (81212a96-09ed-4996-9471-8d729c8e69ed) has been defined in the
> UEFI Specification at least since v2.4 and has recently had additional
> fields defined in v2.7 Section N.2.10 Firmware Error Record Reference.
>
> Add support for parsing and printing the defined fields to give users
> a chance to figure out what's went wrong.
>
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: James Morse <james.morse@arm.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-efi@vger.kernel.org
> ---
>
> Hi,
>
> I ran into this while debugging a boot failure on an end product
> device. Parsing known record types can help the user narrow down the
> investigation quickly to the failing components - firmware error in
> this case.
>
> It would be good to support the record types specified in the
> standard.
>
> Feedback welcome.
>
> Thanks,
> Punit
> ---
>  drivers/firmware/efi/cper.c | 49 +++++++++++++++++++++++++++++++++++++
>  include/linux/cper.h        | 11 +++++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 9d2512913d25..153b95257e23 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -407,6 +407,46 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
>         }
>  }
>
> +static const char * const fw_err_rec_type_strs[] = {
> +       "IPF SAL Error Record",
> +       "SOC Firmware Error Record Type1 (Legacy CrashLog Support)",
> +       "SOC Firmware Error Record Type2",
> +};
> +
> +static void cper_print_fw_err(const char *pfx,
> +                             struct acpi_hest_generic_data *gdata,
> +                             const struct cper_sec_fw_err_rec_ref *fw_err)
> +{
> +       void *buf = acpi_hest_get_payload(gdata);
> +       u32 offset, length = gdata->error_data_length;
> +
> +       printk("%s""Firmware Error Record Type: %s\n", pfx,
> +              fw_err->record_type < ARRAY_SIZE(fw_err_rec_type_strs) ?
> +              fw_err_rec_type_strs[fw_err->record_type] : "unknown");
> +
> +       /* Record Type based on UEFI 2.7 */
> +       if (fw_err->revision == 0)
> +               printk("%s""Record Identifier: %08llx\n", pfx,
> +                      fw_err->record_identifier);
> +       else if (fw_err->revision == 2)
> +               printk("%s""Record Identifier: %pUl\n", pfx,
> +                      &fw_err->record_identifier_guid);
> +

Please use {} for multi-line statements between the ifs

> +       if (fw_err->revision == 0)
> +               offset = offsetof(struct cper_sec_fw_err_rec_ref,
> +                                 record_identifier_guid);
> +       else if (fw_err->revision == 1)
> +               offset = offsetof(struct cper_sec_fw_err_rec_ref,
> +                                 record_identifier);
> +       else
> +               offset = sizeof(*fw_err);
> +

This logic is slightly confusing, so it could do with a comment
regarding which part of the structure is being dumped and why.


> +       buf += offset;
> +       length -= offset;
> +
> +       print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, buf, length, true);
> +}
> +
>  static void cper_print_tstamp(const char *pfx,
>                                    struct acpi_hest_generic_data_v300 *gdata)
>  {
> @@ -494,6 +534,15 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
>                 else
>                         goto err_section_too_small;
>  #endif
> +       } else if (guid_equal(sec_type, &CPER_SEC_FW_ERR_REC_REF)) {
> +               struct cper_sec_fw_err_rec_ref *fw_err = acpi_hest_get_payload(gdata);
> +
> +               printk("%ssection_type: Firmware Error Record Reference\n",
> +                      newpfx);
> +               if (gdata->error_data_length >= sizeof(*fw_err))
> +                       cper_print_fw_err(newpfx, gdata, fw_err);

This doesn't work for revision 0 structures unless they happen to have
some trailing data, which is not necessarily the case, right?

> +               else
> +                       goto err_section_too_small;
>         } else {
>                 const void *err = acpi_hest_get_payload(gdata);
>
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index 4f005d95ce88..5cb57e69df70 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -521,6 +521,17 @@ struct cper_sec_pcie {
>         u8      aer_info[96];
>  };
>
> +/* Firmware Error Record Reference, UEFI v2.7 sec N.2.10  */
> +struct cper_sec_fw_err_rec_ref {
> +       u8 record_type;
> +       union {
> +               u8 revision;
> +               u8 reserved[7];
> +       };

Even though the spec is slightly silly here, I think we can avoid the
union, and just have

  u8 record_type;
  u8 revision;
  u8 reserved[6];

as the leading fields.


> +       u64 record_identifier;
> +       guid_t record_identifier_guid;
> +};
> +
>  /* Reset to default packing */
>  #pragma pack()
>
> --
> 2.26.2
>
