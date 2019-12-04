Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391B211353C
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 19:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfLDS5P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 13:57:15 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44616 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDS5P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 13:57:15 -0500
Received: by mail-qk1-f196.google.com with SMTP id i18so949024qkl.11
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 10:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pl+QectoOe2tlORL4kSqxLKnGi0kFMFcWUCFict5CFQ=;
        b=ullNBA7Tpj02XN/Ij9O6vGSCk/DfijrMPOZMVt2khXUbZesUBx2zrIUnwg1Zz45WhT
         k2+5aGY5dQAOiVkigEfzER3/W2UYWoaelfWyAevJbWebvGrW5EIrAR5u68lZbzlJKLDb
         D2mJ0V89ms3tRgt3hcNPB7HKJPi+32trg65QLldmEPfEzqByOpuk7ow5r219lrJxKp54
         Iz2Z7N2rfT1qsmhIqiUv/lKNK0At9ESQoFuU3RVsbg3g2vvXWQO79ipl9HirR8xbi21i
         5ssWSufP+oyX+h1hQITaR0vWkN3KORomOwGlRKCfpfBFc23utoMh4pdRAkE3gHzcMFrS
         hJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pl+QectoOe2tlORL4kSqxLKnGi0kFMFcWUCFict5CFQ=;
        b=F/9VSABcauJAAiT8OIeL65M/ZsaE+9a/o0oOsu53okm+jwTi5kakrZmaQLw66b5imN
         PVgERkGb+5tUd2ye5CML7OisIl+0wyIkd2zyrBwLaciiSKC1opIzex24FuYZTInF81y/
         CjmT73WY3NzaHGAIU8EfW7Tgw/1VEIGnVGW410CYEmPGphPSiOp7OT8ZgLPubL+Quycd
         2urt58jYmbZhDkaJxFpx5uhmArnV6Ywkvkwpl+UxD0crGnek0990140bj3JJekZVP+C+
         irB+KTIqC+xhFf83yx24DwFeokTe22KCSNqBhCgPVF1JYg3qqisu3ST2YYlYfyONAtkV
         RXXw==
X-Gm-Message-State: APjAAAUx+Lg5GNO/B9SVSwPUWdLoWIJ5tAVZMzTlC67+LSMo5wqxaLdJ
        o2v2bfO/FeIQE0iVTJtY5GAh3cE=
X-Google-Smtp-Source: APXvYqzYagbf+8MKmRfPhkRrCdTYGu+PIANnuXLrboBBQV1O8E/AeMAjY5ftbN/PiqxDsPfKJtBlMg==
X-Received: by 2002:a37:4841:: with SMTP id v62mr4408966qka.444.1575485834425;
        Wed, 04 Dec 2019 10:57:14 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id 62sm4113910qkm.121.2019.12.04.10.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2019 10:57:13 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:57:08 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     James Morse <james.morse@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        mark.rutland@arm.com, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        d.hatayama@fujitsu.com, kexec@lists.infradead.org
Subject: Re: [PATCH] efi/memreserve: register reservations as 'reserved' in
 /proc/iomem
Message-ID: <20191204185708.hdoa5gzmfr547q53@gabell>
References: <20191204145233.11962-1-ardb@kernel.org>
 <20191204171744.o3ijdspnelqn5fgd@gabell>
 <08f05b18-12b2-0ba4-b819-b95ba27d1862@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08f05b18-12b2-0ba4-b819-b95ba27d1862@arm.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 04, 2019 at 06:17:59PM +0000, James Morse wrote:
> Hi Masa,
> 
> On 04/12/2019 17:17, Masayoshi Mizuma wrote:
> > Thank you for sending the patch, but unfortunately it doesn't work for the issue...
> > 
> > After applied your patch, the LPI tables are marked as reserved in
> > /proc/iomem like as:
> > 
> > 80300000-a1fdffff : System RAM
> >   80480000-8134ffff : Kernel code
> >   81350000-817bffff : reserved
> >   817c0000-82acffff : Kernel data
> >   830f0000-830fffff : reserved # Property table
> >   83480000-83480fff : reserved # Pending table
> >   83490000-8349ffff : reserved # Pending table
> > 
> > However, kexec tries to allocate memory from System RAM, it doesn't care
> > the reserved in System RAM.
> 
> > I'm not sure why kexec doesn't care the reserved in System RAM, however,
> 
> Hmm, we added these to fix a problem with the UEFI memory map, and more recently ACPI
> tables being overwritten by kexec.
> 
> Which version of kexec-tools are you using? Could you try:
> https://git.linaro.org/people/takahiro.akashi/kexec-tools.git/commit/?h=arm64/resv_mem

Thanks a lot! It worked and the issue is gone with Ard's patch and
the linaro kexec (arm64/resv_mem branch).

Ard, please feel free to add:

	Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

> 
> 
> > if the kexec behaivor is right, the LPI tables should not belong to
> > System RAM.
> 
> > Like as:
> > 
> > 80300000-830effff : System RAM
> >   80480000-8134ffff : Kernel code
> >   81350000-817bffff : reserved
> >   817c0000-82acffff : Kernel data
> > 830f0000-830fffff : reserved # Property table
> > 83480000-83480fff : reserved # Pending table
> > 83490000-8349ffff : reserved # Pending table
> > 834a0000-a1fdffff : System RAM
> > 
> > I don't have ideas to separete LPI tables from System RAM... so I tried
> > to add a new file to inform the LPI tables to userspace.
> 
> This is how 'nomap' memory appears, we carve it out of System RAM. A side effect of this
> is kdump can't touch it, as you've told it this isn't memory.
> 
> As these tables are memory, mapped by the linear map, I think Ard's patch is the right
> thing to do ... I suspect your kexec-tools doesn't have those patches from Akashi to make
> it honour all second level entries.
 
I used the kexec on the top of master branch:
git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Should we use the linaro kexec for aarch64 machine?
Or will the arm64/resv_mem branch be merged to the kexec on
git.kernel.org...?

Thanks!
Masa
