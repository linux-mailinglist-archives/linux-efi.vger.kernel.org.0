Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73D6F55176
	for <lists+linux-efi@lfdr.de>; Tue, 25 Jun 2019 16:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfFYOVq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Jun 2019 10:21:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42154 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfFYOVq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Jun 2019 10:21:46 -0400
Received: by mail-io1-f68.google.com with SMTP id u19so3498594ior.9
        for <linux-efi@vger.kernel.org>; Tue, 25 Jun 2019 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VmbytSg0ouIhbUItBNo+//y9xHYLFsP4IglnTHr57tE=;
        b=eh+s9PkqqFZDeQSKqAGTnJJcJbi+z22O19g6+4kdMrcEeQLerFk6zw84cwdyxuD+VI
         KemrqiBCtTH7PC4mlaQ2UHAZksnVpmhMD87mnt7JSv7T9ADM0mE7gV6C2ZIN0KQcMwOn
         foftvb8Fs391WJrDssc8167bcKIkrW6h7sVsjwTbYWKftmK+DVVpfikS9ATehCsyYYbl
         8XY/yftebg5PuLAiIhysFUiNDSpdZQiHgHb+0qymiPSxM7GZhIoX0hBaz83lCDa9lVFb
         O78NUM5vskkTFlIbJcIK8opSHnjegnJ8lUOy9MeFzoNvnlhjSuvmpHD7JbE/eLqZXj5W
         WdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VmbytSg0ouIhbUItBNo+//y9xHYLFsP4IglnTHr57tE=;
        b=ta7ZF+X/PCZ0zXUBC9rM/r9ggJvWDegBlYpT7WnaRA5Ln2wOX64O0fqgmh0KWn1Xek
         fcS4Nfap/pluOgWt2Gshj3BjcmVcdeIX/AfwFwD64l3Ru7b9NmgwiimCyk+4dgV6AXtY
         ZWRgUKFcrMnfhFsPIXKjFt/KeeoOhQ54kb1aY6KQ28+88umWltp9tV2RrgoUs5JSViM5
         lRoctzhP47gPEmf9xJVcPjX0EbE6+xq+kNpnL58j/pJXa+7oNqoV/+c0drv/o6dBLHiH
         Ojf8TcOkqFU6JpdQUmaYuyDwGJNRIsxVHCbo/sGhGHyUZG0hxS/wNLxLt/UBuQFkmer5
         mTwA==
X-Gm-Message-State: APjAAAUXZr9NU1NT2KlL5uJa3X9NWuf8BiPWS3ZjmpqeOFHQyiMVXcO9
        YomZdWHUNVfGOUfo4TZqjEy+n8hE27H6Wp/i0Q6yFszWpNLkJQ==
X-Google-Smtp-Source: APXvYqwvLF/p4WciyEUbFJsZzIsIjKnGmkN9hx3i9f7jd7S2/kQ1YVSQGR+NiAyiA+g3uzNSWnrk6Dkqf6Np9PSB0KM=
X-Received: by 2002:a5d:8794:: with SMTP id f20mr4994598ion.128.1561472505258;
 Tue, 25 Jun 2019 07:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190617101134.GA2242@localhost.localdomain> <CAKv+Gu_MYJ=EWOphS=dBG8PJqPjG21J9SGrynD2r60SOemttUA@mail.gmail.com>
 <20190625120944.GA4465@localhost.localdomain>
In-Reply-To: <20190625120944.GA4465@localhost.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 25 Jun 2019 16:21:33 +0200
Message-ID: <CAKv+Gu_cdjU49d5JSJKJ_2Eb2Pp2JY=xe=39J3KyVs7qQnke2g@mail.gmail.com>
Subject: Re: [RFC PATCH] Export Runtime Configuration Interface table to sysfs
To:     Narendra.K@dell.com
Cc:     Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 25 Jun 2019 at 14:10, <Narendra.K@dell.com> wrote:
>
> On Fri, Jun 21, 2019 at 06:35:42PM +0200, Ard Biesheuvel wrote:
> > (+ Peter)
> >
> > On Mon, 17 Jun 2019 at 12:11, <Narendra.K@dell.com> wrote:
> > >
> > > From: Narendra K <Narendra.K@dell.com>
> > >
> > > System firmware advertises the address of the 'Runtime
> > > Configuration Interface table version 2 (RCI2)' via
> > > an EFI Configuration Table entry. This code retrieves the RCI2
> > > table from the address and exports it to sysfs as a binary
> > > attribute 'rci2' under /sys/firmware/efi/tables directory.
> > > The approach adopted is similar to the attribute 'DMI' under
> > > /sys/firmware/dmi/tables.
> [...]
> > > ---
> > > Hi, the patch is created on kernel version 5.2-rc4. It applies to
> > > 5.2-rc5 also. If the approach looks correct, I will resubmit with RFC
> > > tag removed.
> > >
>
> Hi Ard,
>
> Thank you for the review comments.
>
> > Unfortunately, we cannot implement a  generic interface for dumping
> > config tables, since there is no generic method to record the length.
> > So I don't have any problems with doing it this way.
> >
> > I do have some comments, though.
> >
> > First of all, do you know which memory type is used for this table? (more below)
>
> The memory type used for the table is EfiReservedMemoryType.
>

OK

> [...]
> > > +obj-$(CONFIG_EFI)                      += efi.o vars.o reboot.o memattr.o tpm.o rci2_table.o
> > >  obj-$(CONFIG_EFI)                      += capsule.o memmap.o
> > >  obj-$(CONFIG_EFI_VARS)                 += efivars.o
> > >  obj-$(CONFIG_EFI_ESRT)                 += esrt.o
> > > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > > index 16b2137d117c..2fe114ff8149 100644
> > > --- a/drivers/firmware/efi/efi.c
> > > +++ b/drivers/firmware/efi/efi.c
> > > @@ -53,6 +53,7 @@ struct efi __read_mostly efi = {
> > >         .rng_seed               = EFI_INVALID_TABLE_ADDR,
> > >         .tpm_log                = EFI_INVALID_TABLE_ADDR,
> > >         .mem_reserve            = EFI_INVALID_TABLE_ADDR,
> > > +       .rci2                   = EFI_INVALID_TABLE_ADDR,
> >
> > Does this really need to live in the efi struct?
>
> It probably need not be part of struct efi. We could define a struct of
> type 'efi_config_table_type_t' in the rci2_table.c. Did you have a
> similar idea in mind ? If yes, I will modify and test this idea.
>

Yes, I'd like to start keeping these things separate.

I pushed a branch here

https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next

that changes the way uv_systab is handled, and moves it into arch/x86.
Please follow that pattern instead.

> >
> > >  };
> > >  EXPORT_SYMBOL(efi);
> > >
> > > @@ -73,6 +74,7 @@ static unsigned long *efi_tables[] = {
> > >         &efi.esrt,
> > >         &efi.properties_table,
> > >         &efi.mem_attr_table,
> > > +       &efi.rci2,
> > >  };
> > >
> >
> > AFAICT, this table is only used by memremap_is_efi_data() to decide
> > whether a page should be map as unencrypted, and if the address is in
> > boot services data or runtime services data, the test will already
> > success, regardless of whether it appears in this enumeration.
>
> Yes. Before 'memremap_is_efi_data()' checks if the memory type is boot
> services data for runtime services data, it checks if the address is a
> 'table' address in 'efi_is_table_address'. I added it because of this
> check. Since the memory type used for the table is efi reserved type, we
> need to add the table address to 'efi_tables' array so that it could be
> checked in 'efi_is_table_address'. Please share your thought on this.
>

OK. My branch ^^^ moves this into arch/x86 as well, please add it there


> >
> > >  struct mm_struct efi_mm = {
> > > @@ -384,6 +386,9 @@ static int __init efisubsys_init(void)
> > >                 goto err_remove_group;
> > >         }
> > >
> > > +       if (efi_rci2_sysfs_init() != 0)
> > > +               pr_debug("efi rci2: sysfs attribute creation under /sys/firmware/efi/ failed");
> > > +
> > >         return 0;
> > >
> > >  err_remove_group:
> > > @@ -488,6 +493,12 @@ static __initdata efi_config_table_type_t common_tables[] = {
> > >         {NULL_GUID, NULL, NULL},
> > >  };
> > >
> > > +/* OEM Tables */
> > > +static __initdata efi_config_table_type_t oem_tables[] = {
> > > +       {DELLEMC_EFI_RCI2_TABLE_GUID, "RCI2", &efi.rci2},
> >
> > Please drop the string. We don't have to print the presence of this
> > table in the bootlog since it has no significance to the OS itself.
>
> Okay. I will drop this in the next version of the patch.
>
> >
> > > +       {NULL_GUID, NULL, NULL},
> > > +};
> > > +
> >
> > Do we really need a separate oem_tables[] array?
>
> The RCI2 table did not seem to be part of the group of common tables
> such as SMBIOS and ACPI. To indicate this, I created a separate array.
> It seems like it is not required. Having the array allows to leverage
> the table matching code in 'match_config_table' function. Would you prefer
> to have this entry added to the 'common_tables' array ?
>

Please add it to the arch_tables array in arch/x86 (if my assumption
is correct that this is x86-only)

> [...]
> > > +
> > > +int __init efi_rci2_table_init(void)
> > > +{
> > > +       rci2_base = early_memremap(efi.rci2,
> > > +                                  sizeof(struct rci2_table_global_hdr));
> > > +       if (!rci2_base) {
> > > +               pr_debug("RCI2 table init failed - could not map RCI2 table\n");
> > > +               return -ENOMEM;
> > > +       }
> > > +
> >
> > Do we really need to do this early? And is it guaranteed that the
> > memory will not be given to the OS for general allocation?
>
> As the memory type is efi reserved type, it is guaranteed that the
> memory will not be give to OS for general allocation. It is mapped here
> to determine the size of the table and unmapped in the same function.
>
> Would you prefer to merge this function into 'efi_rci2_sysfs_init' function ?
>

Yes. Only user space needs to access this, so we can defer this to
later, when the normal memremap() functions are available.

> >
> >
> > > +       if (strncmp(rci2_base +
> > > +                   offsetof(struct rci2_table_global_hdr, rci2_sig),
> > > +                   RCI_SIGNATURE, 4)) {
> > > +               memunmap(rci2_base);
> > > +               pr_debug("RCI2 table init failed - incorrect signature\n");
> > > +               return -ENODEV;
> > > +       }
> > > +
> > > +       rci2_table_len = *(u32 *)(rci2_base +
> > > +                                 offsetof(struct rci2_table_global_hdr,
> > > +                                 rci2_len));
> > > +
> > > +       early_memunmap(rci2_base, sizeof(struct rci2_table_global_hdr));
> > > +
> > > +       return 0;
> > > +}
>
> [...]
>
> > > +
> > > +static u16 checksum(void)
> > > +{
> > > +       u8 len_is_odd = rci2_table_len % 2;
> > > +       u32 chksum_len = rci2_table_len;
> > > +       u16 *base = (u16 *)rci2_base;
> > > +       u8 buf[2] = {0};
> > > +       u32 offset = 0;
> > > +       u16 chksum = 0;
> > > +
> > > +       if (len_is_odd)
> > > +               chksum_len -= 1;
> > > +
> > > +       while (offset < chksum_len) {
> > > +               chksum += *base;
> > > +               offset += 2;
> > > +               base++;
> > > +       }
> > > +
> > > +       if (len_is_odd) {
> > > +               buf[0] = *(u8 *)base;
> > > +               chksum += *(u16 *)(buf);
> > > +       }
> > > +
> > > +       return chksum;
> > > +}
> > > +
> >
> > What is this random checksum function? Which algorithm does it
> > implement, and did you check whether we already have a library
> > function for it?
>
> It does not implement any algorithm. The 16 bit sum of rci2_chksum field in the
> struct rci2_table_global_hdr and rest of bytes of the table needs to be zero.
> If length of the table is odd, a single byte  with value zero needs to be added
> at the end for the purpose of checksum calculation.
>
> I checked in the library and did not find a function implementing
> similar functionality. Please let me know if I missed any detail here.
>

OK.

> >
> >
> > > +int __init efi_rci2_sysfs_init(void)
> > > +{
> > > +
> > > +       struct kobject *tables_kobj;
> > > +       int ret = -ENOMEM;
> > > +
> > > +       if (!rci2_table_len)
> > > +               goto err;
> > > +
> > > +       rci2_base = memremap(efi.rci2, rci2_table_len, MEMREMAP_WB);
> > > +       if (!rci2_base) {
> > > +               pr_debug("RCI2 table - could not map RCI2 table\n");
> > > +               return -ENOMEM;
> > > +       }
> > > +
> > > +       if (checksum() != 0) {
> > > +               pr_debug("RCI2 table - incorrect checksum\n");
> > > +               ret = -ENODEV;
> > > +               goto err_unmap;
> > > +       }
> > > +
> > > +       tables_kobj = kobject_create_and_add("tables", efi_kobj);
> > > +       if (!tables_kobj) {
> > > +               pr_debug("RCI2 table - tables_kobj creation failed\n");
> > > +               goto err_unmap;
> > > +       }
> > > +
> > > +       bin_attr_rci2.size = rci2_table_len;
> > > +       bin_attr_rci2.private = rci2_base;
> > > +       ret = sysfs_create_bin_file(tables_kobj, &bin_attr_rci2);
> > > +       if (ret != 0) {
> > > +               pr_debug("RCI2 table - rci2 sysfs bin file creation failed\n");
> > > +               kobject_del(tables_kobj);
> > > +               kobject_put(tables_kobj);
> > > +               goto err_unmap;
> > > +       }
> > > +
> > > +       return 0;
> > > +
> > > + err_unmap:
> > > +       memunmap(rci2_base);
> > > + err:
> > > +       pr_debug("RCI2 table - sysfs initialization failed\n");
> > > +       return ret;
> > > +}
> > > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > > index 6ebc2098cfe1..3a3f37ee5c48 100644
> > > --- a/include/linux/efi.h
> > > +++ b/include/linux/efi.h
> > > @@ -691,6 +691,9 @@ void efi_native_runtime_setup(void);
> > >  #define LINUX_EFI_TPM_EVENT_LOG_GUID           EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
> > >  #define LINUX_EFI_MEMRESERVE_TABLE_GUID                EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
> > >
> > > +/* OEM GUIDs */
> > > +#define DELLEMC_EFI_RCI2_TABLE_GUID            EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
> > > +
> > >  typedef struct {
> > >         efi_guid_t guid;
> > >         u64 table;
> > > @@ -997,6 +1000,7 @@ extern struct efi {
> > >         unsigned long rng_seed;         /* UEFI firmware random seed */
> > >         unsigned long tpm_log;          /* TPM2 Event Log table */
> > >         unsigned long mem_reserve;      /* Linux EFI memreserve table */
> > > +       unsigned long rci2;             /* Dell EMC EFI RCI2 Table */
> > >         efi_get_time_t *get_time;
> > >         efi_set_time_t *set_time;
> > >         efi_get_wakeup_time_t *get_wakeup_time;
> > > @@ -1712,6 +1716,9 @@ struct linux_efi_tpm_eventlog {
> > >
> > >  extern int efi_tpm_eventlog_init(void);
> > >
> > > +extern int efi_rci2_table_init(void);
> > > +extern int efi_rci2_sysfs_init(void);
> > > +
> > >  /*
> > >   * efi_runtime_service() function identifiers.
> > >   * "NONE" is used by efi_recover_from_page_fault() to check if the page
> > > --
> > > 2.18.1
> > >
> > > With regards,
> > > Narendra K
> --
> With regards,
> Narendra K
