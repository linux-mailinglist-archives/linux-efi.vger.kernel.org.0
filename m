Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7927B1CF2D7
	for <lists+linux-efi@lfdr.de>; Tue, 12 May 2020 12:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgELKsN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 May 2020 06:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729639AbgELKsL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 12 May 2020 06:48:11 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABA5A20731;
        Tue, 12 May 2020 10:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589280490;
        bh=ec2u7fiwEX8z3gl7q4XcFA1SD2R8KacLDpSUINJUYBg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HwPdPyFu87aAL4/LLpNjBOyFO7DQ5+aEu5nTHautuwZQLmwEjjfK+lUIvds0KIQZu
         0V3BZEU61nKPMMQzPMny0yWfyMqkhjYKPaj6vrd32+gzGZYwDgSn7v7X6arODd221s
         8AAn5vWXDVU7J3/wc2QxC2LqbhWlUpF/FcbAxqYE=
Received: by mail-io1-f54.google.com with SMTP id e18so499352iog.9;
        Tue, 12 May 2020 03:48:10 -0700 (PDT)
X-Gm-Message-State: AGi0PublluOoGjc+M8zwjad9oOSh0OBOZZAPuwzG19yuXwNk6Gjj8HKF
        D3UeAJnXb7H5MU6nKe4Z9ooQWOJjNlBA7XmhzKQ=
X-Google-Smtp-Source: APiQypIgQdCurvaC8kNfI9ogq1z5tOeVBnUy1rhQqT5JvdNhwj93KsyomBZKFN1Y2z/9kmeCojNdoMpGCdTiJzXEQW4=
X-Received: by 2002:a02:c6b4:: with SMTP id o20mr7529554jan.134.1589280490038;
 Tue, 12 May 2020 03:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200512045502.3810339-1-punit1.agrawal@toshiba.co.jp>
In-Reply-To: <20200512045502.3810339-1-punit1.agrawal@toshiba.co.jp>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 12 May 2020 12:47:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGNWptRShYVtDwoB7jL1_2M1ioroFV=veFt0MB=n6_-OQ@mail.gmail.com>
Message-ID: <CAMj1kXGNWptRShYVtDwoB7jL1_2M1ioroFV=veFt0MB=n6_-OQ@mail.gmail.com>
Subject: Re: [Patch v2] efi: cper: Add support for printing Firmware Error
 Record Reference
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 12 May 2020 at 06:55, Punit Agrawal
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
> a chance to figure out what went wrong.
>
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: James Morse <james.morse@arm.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-efi@vger.kernel.org
> ---
> Hi Ard,
>
> I've updated the patch based on your feedback.
>
> As you noted, some aspects of the spec make it a bit tricky to support
> all revisions in a nice way (e.g., size check) but this version should
> fix existing issues.
>
> Thanks,
> Punit
>
> v1[0] -> v2:
> * Simplified error record structure definition
> * Fixed size check
> * Added comment to clarify offset calculation for dumped data
> * Style fixes for multiline if blocks
>

Thanks. I will queue this as a fix.


> [0] https://lkml.kernel.org/lkml/20200427085242.2380614-1-punit1.agrawal@toshiba.co.jp/
> ---
>  drivers/firmware/efi/cper.c | 62 +++++++++++++++++++++++++++++++++++++
>  include/linux/cper.h        |  9 ++++++
>  2 files changed, 71 insertions(+)
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 9d2512913d25..f564e15fbc7e 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -407,6 +407,58 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
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
> +       printk("%s""Revision: %d\n", pfx, fw_err->revision);
> +
> +       /* Record Type based on UEFI 2.7 */
> +       if (fw_err->revision == 0) {
> +               printk("%s""Record Identifier: %08llx\n", pfx,
> +                      fw_err->record_identifier);
> +       } else if (fw_err->revision == 2) {
> +               printk("%s""Record Identifier: %pUl\n", pfx,
> +                      &fw_err->record_identifier_guid);
> +       }
> +
> +       /*
> +        * The FW error record may contain trailing data beyond the
> +        * structure defined by the specification. As the fields
> +        * defined (and hence the offset of any trailing data) vary
> +        * with the revision, set the offset to account for this
> +        * variation.
> +        */
> +       if (fw_err->revision == 0) {
> +               /* record_identifier_guid not defined */
> +               offset = offsetof(struct cper_sec_fw_err_rec_ref,
> +                                 record_identifier_guid);
> +       } else if (fw_err->revision == 1) {
> +               /* record_identifier not defined */
> +               offset = offsetof(struct cper_sec_fw_err_rec_ref,
> +                                 record_identifier);
> +       } else {
> +               offset = sizeof(*fw_err);
> +       }
> +
> +       buf += offset;
> +       length -= offset;
> +
> +       print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, buf, length, true);
> +}
> +
>  static void cper_print_tstamp(const char *pfx,
>                                    struct acpi_hest_generic_data_v300 *gdata)
>  {
> @@ -494,6 +546,16 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
>                 else
>                         goto err_section_too_small;
>  #endif
> +       } else if (guid_equal(sec_type, &CPER_SEC_FW_ERR_REC_REF)) {
> +               struct cper_sec_fw_err_rec_ref *fw_err = acpi_hest_get_payload(gdata);
> +
> +               printk("%ssection_type: Firmware Error Record Reference\n",
> +                      newpfx);
> +               /* The minimal FW Error Record contains 16 bytes */
> +               if (gdata->error_data_length >= SZ_16)
> +                       cper_print_fw_err(newpfx, gdata, fw_err);
> +               else
> +                       goto err_section_too_small;
>         } else {
>                 const void *err = acpi_hest_get_payload(gdata);
>
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index 4f005d95ce88..8537e9282a65 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -521,6 +521,15 @@ struct cper_sec_pcie {
>         u8      aer_info[96];
>  };
>
> +/* Firmware Error Record Reference, UEFI v2.7 sec N.2.10  */
> +struct cper_sec_fw_err_rec_ref {
> +       u8 record_type;
> +       u8 revision;
> +       u8 reserved[6];
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
