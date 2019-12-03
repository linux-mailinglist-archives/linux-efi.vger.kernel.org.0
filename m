Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1B3E10F479
	for <lists+linux-efi@lfdr.de>; Tue,  3 Dec 2019 02:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfLCB3C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Dec 2019 20:29:02 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34333 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfLCB3B (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 2 Dec 2019 20:29:01 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so815648qvf.1;
        Mon, 02 Dec 2019 17:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RNgvM+k/lpMnH+XOjhYxTq6D1hp93U5fCuPYP6yw85g=;
        b=KH4tvJaQ/O2fFG29Wj3m7IMzniYRtYmBaYBlUN7XdIVedhY/rE9NZfP+UtUgvZ2Jra
         VcRNQylQKNUWRAd7gtTvbTz2tYZzugLGJebNmlRUQ1hpy77M2PRbbGtH6k65vtyt2CNR
         lBI46czPccfxmdstgc6oawjKOKysx1pGcNcbeWzov94SLzQmp12NoGBQB+bFLXEJlc7z
         zkSUCYBvH9cyUvyYFyQG3HhjdWjS8x4hv3o5315BMOM5uAys7n5CUflodao48Wd/nKDU
         tVE7C/d6sY94BdDik+UqgB0ZdgoEVlOhktW5xtxxggzm9BNFpNWGFR/YJxcq/qI2Rqfy
         L7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RNgvM+k/lpMnH+XOjhYxTq6D1hp93U5fCuPYP6yw85g=;
        b=uWe80ba7VP9wh5V35F1ti7ifa6i4dMG7SnpaNL4fGHf08xp36cdViKxcEuSDWtjjiG
         njnvvQ/B7P+8TwQUb9+CKGqsNsm6fRZgOekW34LhpEfIU2a9a9OU5ZEGrPeY31mr5Wci
         KxY467LJJZjo2j4sDy8PP+tyTwz0TujxvcbuIbL7edrgXFuKYhOehDbsGlIHFi2Y+xlk
         hOzfM+UW9z+w5oTkhVTOm/0oSt1yWOQwNdsZDdDheOJwgJIb4y+FlfhaBrF0wKB1JzND
         m2cXVgC2akWkxMGOeOUyie3Jmt977dS73t5+zlERnRqXtR6Ty8qUq4v4h0BXtSyBW7BW
         yovw==
X-Gm-Message-State: APjAAAUYz5ID5F+E1FF/SycIIWrQLzkAVl148xbaDxqX4FHMNDEwTlH+
        7Z60U8TyXiVwo2XecbqP4g==
X-Google-Smtp-Source: APXvYqzu3dZjpDk9O/4U9qT5DGI9leNoMi9/ywTWw0jInOxp/9Jd8Z43U+tV2M8UfLnAF8ODQwxJgw==
X-Received: by 2002:a0c:89f2:: with SMTP id 47mr2677364qvs.43.1575336540308;
        Mon, 02 Dec 2019 17:29:00 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id y18sm762179qtn.11.2019.12.02.17.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 17:28:58 -0800 (PST)
Date:   Mon, 2 Dec 2019 20:28:53 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>, d.hatayama@fujitsu.com
Subject: Re: [PATCH] efi: arm64: Introduce /sys/firmware/efi/memreserve to
 tell the persistent pages
Message-ID: <20191203012853.hwnbs6dfcbnkbtgp@gabell>
References: <20191125184944.15556-1-msys.mizuma@gmail.com>
 <c27b6f69-befc-0c88-24b9-7b89d4f6e5a6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c27b6f69-befc-0c88-24b9-7b89d4f6e5a6@gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Nov 29, 2019 at 01:25:36PM +0100, Matthias Brugger wrote:
> 
> 
> On 25/11/2019 19:49, Masayoshi Mizuma wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > kexec reboot stops in early boot sequence because efi_config_parse_tables()
> > refers garbage data. We can see the log with memblock=debug kernel option:
> > 
> >   efi:  ACPI 2.0=0x9821790014  PROP=0x8757f5c0  SMBIOS 3.0=0x9820740000  MEMRESERVE=0x9820bfdc58
> >   memblock_reserve: [0x0000009820bfdc58-0x0000009820bfdc67] efi_config_parse_tables+0x228/0x278
> >   memblock_reserve: [0x0000000082760000-0x00000000324d07ff] efi_config_parse_tables+0x228/0x278
> >   memblock_reserve: [0xcc4f84ecc0511670-0x5f6e5214a7fd91f9] efi_config_parse_tables+0x244/0x278
> >   memblock_reserve: [0xd2fd4144b9af693d-0xad0c1db1086f40a2] efi_config_parse_tables+0x244/0x278
> >   memblock_reserve: [0x0c719bb159b1fadc-0x5aa6e62a1417ce12] efi_config_parse_tables+0x244/0x278
> >   ...
> > 
> > That happens because 0x82760000, struct linux_efi_memreserve, is destroyed.
> > 0x82760000 is pointed from efi.mem_reseve, and efi.mem_reserve points the
> > head page of LPI pending table and LPI property table which are allocated by
> > gic_reserve_range().
> > 
> > The destroyer is kexec. kexec locates the initrd to the area:
> > 
> >   ]# kexec -d -l /boot/vmlinuz-5.4.0-rc7 /boot/initramfs-5.4.0-rc7.img --reuse-cmdline
> >   ...
> >   initrd: base 82290000, size 388dd8ah (59301258)
> >   ...
> > 
> > From dynamic debug log. initrd is located in segment[1]:
> >   machine_kexec_prepare:70:
> >     kexec kimage info:
> >       type:        0
> >       start:       85b30680
> >       head:        0
> >       nr_segments: 4
> >         segment[0]: 0000000080480000 - 0000000082290000, 0x1e10000 bytes, 481 pages
> >         segment[1]: 0000000082290000 - 0000000085b20000, 0x3890000 bytes, 905 pages
> >         segment[2]: 0000000085b20000 - 0000000085b30000, 0x10000 bytes, 1 pages
> >         segment[3]: 0000000085b30000 - 0000000085b40000, 0x10000 bytes, 1 pages
> > 
> > kexec searches the memory region to locate initrd through
> > "System RAM" in /proc/iomem. The pending tables are included in
> > "System RAM" because they are allocated by alloc_pages(), so kexec
> > destroys the LPI pending tables.
> > 
> 
> Doesn't that mean that you haven't enough memory reserved so that you have to
> fallback to allocate it via __get_free_page()?

That's a not fallback allocation. The pending tables and also property
tables are allocated by alloc_pages() on its_allocate_prop_table() and
its_allocate_pending_table().

> 
> 
> > Introduce /sys/firmware/efi/memreserve to tell the pages pointed by
> > efi.mem_reserve so that kexec can avoid the area to locate initrd.
> > 
> 
> Doesn't that need a patch for kexec-tools to actually take this into account?

Yes, we need a patch for kexec-tools as well. I'm preparing the kexec
patch.

> 
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > ---
> >  drivers/firmware/efi/efi.c | 45 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 44 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index e98bbf8e5..0aa07cc09 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -141,6 +141,47 @@ static ssize_t systab_show(struct kobject *kobj,
> >  
> >  static struct kobj_attribute efi_attr_systab = __ATTR_RO_MODE(systab, 0400);
> >  
> > +static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
> > +#ifdef CONFIG_KEXEC
> > +static ssize_t memreserve_show(struct kobject *kobj,
> > +			   struct kobj_attribute *attr, char *buf)
> > +{
> > +	struct linux_efi_memreserve *rsv;
> > +	phys_addr_t start, end;
> > +	unsigned long prsv;
> > +	char *str = buf;
> > +	int count, i;
> > +
> > +	if (!kobj || !buf)
> > +		return -EINVAL;
> > +
> > +	if ((efi_memreserve_root == (void *)ULONG_MAX) ||
> > +			(!efi_memreserve_root))
> > +		return -ENODEV;
> > +
> > +	for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
> > +		rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
> > +		if (!rsv) {
> > +			pr_err("Could not map efi_memreserve\n");
> > +			return -ENOMEM;
> > +		}
> > +		count = atomic_read(&rsv->count);
> > +		for (i = 0; i < count; i++) {
> > +			start = rsv->entry[i].base;
> > +			end = start + rsv->entry[i].size - 1;
> > +
> > +			str += sprintf(str, "%pa-%pa\n", &start, &end);
> 
> What happens if we provide a buf which is too small?

Good point.
The strings may exceed the buffer size (PAGE_SIZE) in case
efi_memreserve_root has a lot of entries.
It might be better to use seq_printf() to show efi_memreserve_root...
I'll move the file from a sysfs entry to a proc entry so that 
efi_memreserve_root can be handled by seq_printf().

Thanks,
Masa
