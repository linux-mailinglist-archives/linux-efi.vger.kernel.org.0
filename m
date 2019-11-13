Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 260B4FB90A
	for <lists+linux-efi@lfdr.de>; Wed, 13 Nov 2019 20:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfKMTn0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Nov 2019 14:43:26 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46869 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKMTn0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Nov 2019 14:43:26 -0500
Received: by mail-qt1-f194.google.com with SMTP id r20so3868012qtp.13;
        Wed, 13 Nov 2019 11:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LTpeEfUp2aDF2PuVPItGfVBk3+wf98fXG2ncSzi/Vdk=;
        b=tXz+MujYAez3+OpD7+2t674yspYgv6gqgmmgqG8P5mkHlKw1lGZKIqdaqMlTltismO
         2MSmHXgtSsuTAdXEMg3NxWRmaf4ifUEYqu/nSDxOCaefc5XLN+sOJyC67lhgdNiFDghd
         ewDgcka08ijUkVgD7/CRLUykL00f+Ru6rlWkThupHKl//CGc5AZfLQwSHDyOfIk3YYFM
         QpZjRPNjfFhtMF+PCZU0L4CmvrEGwsO03YVUwTMWS2LO12+FhB8sjYHWO05KdPMTAajC
         m8X3EOg5jyLpiga9HQhExsqG+pMPjeyn33Ck/orFk4lyDiraONSmkN8wsfp5t/8uBJ2r
         acTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LTpeEfUp2aDF2PuVPItGfVBk3+wf98fXG2ncSzi/Vdk=;
        b=OxoSS9VgYSOWS1uD7y95i5lW5Mha2AgTjvxbK1TyZuJUkSHuj2ci0qRdF/uzFaiAKQ
         nf5yFcnDnHzw0Gog8ZzVE2hJz6ogpRAk5x8T9tq2joiErQT5D3ROQnm1qo+ZU5BqbckB
         3YHIF6Gpuy2X3s43ZpSwg1uo9/tmjHhESZU0ZV2D4KUyZfY10z3CYe7Jkeqa7nsZzkR2
         Xf9L85FV/hFLFW2Kwez3raZ6IyznaTbnaOzulLoE8zN8JM31uuFw2E3R6Y82R8uKd/fs
         wOSrjtUSbHpPusess2G6LiZ36IpxRLXV9b11je3IiLZY+8kpyWnQxnP056ClSzZProt7
         93OQ==
X-Gm-Message-State: APjAAAVmVCvnz0WEMfzlmo1T79+ULbvgAk2Yqhk5B2tbVOJHLRHS2xcV
        6ETnpqDoAYwDYCJXdpbPlQ==
X-Google-Smtp-Source: APXvYqwuQjXnzhWn63dYa+pvmHYPOPoyVfz7wGIAq+IWPm8a4FT9l+pVXnuyAqjs+W+XzuMuGrJfbw==
X-Received: by 2002:aed:2357:: with SMTP id i23mr4552514qtc.365.1573674203724;
        Wed, 13 Nov 2019 11:43:23 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f191sm1419361qke.62.2019.11.13.11.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 11:43:23 -0800 (PST)
Date:   Wed, 13 Nov 2019 14:43:16 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "m.mizuma@jp.fujitsu.com" <m.mizuma@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] efi: arm64: Introduce /sys/firmware/efi/memreserve
 to tell the persistent pages
Message-ID: <20191113194229.jfaawdhummneri6s@gabell>
References: <20191112165303.24270-1-msys.mizuma@gmail.com>
 <OSBPR01MB4006D6F586695E2B867C95F095760@OSBPR01MB4006.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB4006D6F586695E2B867C95F095760@OSBPR01MB4006.jpnprd01.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 13, 2019 at 07:59:04AM +0000, d.hatayama@fujitsu.com wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > kexec reboot stucks because efi_config_parse_tables() refers garbage
> >  (with memblock=debug):
> > 
> >   efi:  ACPI 2.0=0x9821790014  PROP=0x8757f5c0  SMBIOS 3.0=0x9820740000
> > MEMRESERVE=0x9820bfdc58
> >   memblock_reserve: [0x0000009820bfdc58-0x0000009820bfdc67]
> > efi_config_parse_tables+0x228/0x278
> >   memblock_reserve: [0x0000000082760000-0x00000000324d07ff]
> > efi_config_parse_tables+0x228/0x278
> >   memblock_reserve: [0xcc4f84ecc0511670-0x5f6e5214a7fd91f9]
> > efi_config_parse_tables+0x244/0x278
> >   memblock_reserve: [0xd2fd4144b9af693d-0xad0c1db1086f40a2]
> > efi_config_parse_tables+0x244/0x278
> >   memblock_reserve: [0x0c719bb159b1fadc-0x5aa6e62a1417ce12]
> > efi_config_parse_tables+0x244/0x278
> >   ...
> > 
> > That happens because 0x82760000, struct linux_efi_memreserve, is destroyed.
> > 0x82760000 is pointed from efi.mem_reseve, and efi.mem_reserve points the
> > head page of pending table and prop table which are allocated by
> > gic_reserve_range().
> > 
> > The destroyer is kexec. kexec locates the inird to the area:
> > 
> > # kexec -d -l /boot/vmlinuz-5.4.0-rc7 /boot/initramfs-5.4.0-rc7.img
> > --reuse-cmdline
> > ...
> > initrd: base 82290000, size 388dd8ah (59301258)
> > ...
> > 
> > From dynamic debug log:
> >   machine_kexec_prepare:70:
> >     kexec kimage info:
> >       type:        0
> >       start:       85b30680
> >       head:        0
> >       nr_segments: 4
> >         segment[0]: 0000000080480000 - 0000000082290000, 0x1e10000 bytes, 481
> > pages
> >         segment[1]: 0000000082290000 - 0000000085b20000, 0x3890000 bytes, 905
> > pages
> >         segment[2]: 0000000085b20000 - 0000000085b30000, 0x10000 bytes, 1
> > pages
> >         segment[3]: 0000000085b30000 - 0000000085b40000, 0x10000 bytes, 1
> > pages
> > 
> > kexec searches the appropriate memory region to locate initrd through "System
> > RAM"
> > in /proc/iomem. The pending tables are included in "System RAM" because they
> > are
> > allocated by alloc_pages(), so kexec destroys the pending tables.
> > 
> > Introduce /sys/firmware/efi/memreserve to tell the pages pointed by
> > efi.mem_reserve
> > so that kexec can avoid the area to locate initrd.
> > 
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > ---
> >  drivers/firmware/efi/efi.c | 32 +++++++++++++++++++++++++++++++-
> >  1 file changed, 31 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index e98bbf8e5..67b21ae7a 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -141,6 +141,36 @@ static ssize_t systab_show(struct kobject *kobj,
> > 
> >  static struct kobj_attribute efi_attr_systab = __ATTR_RO_MODE(systab, 0400);
> > 
> > +static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
> > +static ssize_t memreserve_show(struct kobject *kobj,
> > +			   struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct linux_efi_memreserve *rsv;
> > +	unsigned long prsv;
> > +	char *str = buf;
> > +	int index, i;
> > +
> > +	if (!kobj || !buf)
> > +		return -EINVAL;
> > +
> > +	if (!efi_memreserve_root)
> > +		return -ENODEV;
> 
> Other functions use different conditions.
> The latter efi_memreserve_root == (void *)ULONG_MAX is correct?
> 
> static int __init efi_memreserve_map_root(void)
> {
>         if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
>                 return -ENODEV;
> int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
> {
>         struct linux_efi_memreserve *rsv;
>         unsigned long prsv;
>         int rc, index;
> 
>         if (efi_memreserve_root == (void *)ULONG_MAX)
>                 return -ENODEV;

I think it's better to add both checks like as:

        if ((efi_memreserve_root == (void *)ULONG_MAX) ||
                        (!efi_memreserve_root))
                return -ENODEV;
> 
> > +
> > +	for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
> > +		rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
> 
> memremap() could fail with NULL as a return value.
> You need to deal with such case.
> 
> It looks to me efi_mem_reserve_persistent() also doesn't deal with this.
> Maybe you should fix this, too.

OK, I'll post a patch sepaletely to add the sanity check.

> 
> > +		index = atomic_read(&rsv->count);
> > +		for (i = 0; i < index; i++)
> > +			str += sprintf(str, "%llx-%llx\n",
> > +				rsv->entry[i].base,
> > +				rsv->entry[i].base + rsv->entry[i].size -
> > 1);
> 
> Is memreserve supported on 32-bit system?
> If so, phy_addr_t could have a type of 4-byte length in such system
> (not so if with PAE) and then %llx could lead to inconsistent type error.
> It's enough to add a cast to unsigned long long.

Good catch. I'll modify the sprintf() format to
use %pa like as:

  phys_addr_t start, end;

  for (i = 0; i < index; i++) {
          start = rsv->entry[i].base;
          end = start + rsv->entry[i].size - 1;

          str += sprintf(str, "%pa-%pa\n", &start, &end);
  }

Thanks,
Masa
> 
> > +		memunmap(rsv);
> > +	}
> > +
> > +	return str - buf;
> > +}
> > +
> > +static struct kobj_attribute efi_attr_memreserve =
> > __ATTR_RO_MODE(memreserve, 0444);
> > +
> >  #define EFI_FIELD(var) efi.var
> > 
> >  #define EFI_ATTR_SHOW(name) \
> > @@ -172,6 +202,7 @@ static struct attribute *efi_subsys_attrs[] = {
> >  	&efi_attr_runtime.attr,
> >  	&efi_attr_config_table.attr,
> >  	&efi_attr_fw_platform_size.attr,
> > +	&efi_attr_memreserve.attr,
> >  	NULL,
> >  };
> > 
> > @@ -955,7 +986,6 @@ int efi_status_to_err(efi_status_t status)
> >  }
> > 
> >  static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
> > -static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
> > 
> >  static int __init efi_memreserve_map_root(void)
> >  {
> > --
> > 2.18.1
> 
