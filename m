Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC183BDDCB
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jul 2021 21:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhGFTKU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 6 Jul 2021 15:10:20 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45485 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhGFTKU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 6 Jul 2021 15:10:20 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4GKBrm0xkKz1qtQY;
        Tue,  6 Jul 2021 21:07:35 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4GKBrl5Kw0z1r6PF;
        Tue,  6 Jul 2021 21:07:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id fw-QNfhDit5D; Tue,  6 Jul 2021 21:07:34 +0200 (CEST)
X-Auth-Info: hqIQnrhVC+qQkOv/oIdG6t6LH5c2HROoPvvXkgRTysOBYhEovzDSoGAHzQryEqTD
Received: from igel.home (ppp-46-244-191-40.dynamic.mnet-online.de [46.244.191.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  6 Jul 2021 21:07:34 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id D078B2C0B25; Tue,  6 Jul 2021 21:07:33 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] RISC-V: load initrd wherever it fits into memory
References: <20210629134018.62859-1-xypron.glpk@gmx.de>
X-Yow:  How many retired bricklayers from FLORIDA are out purchasing
 PENCIL SHARPENERS right NOW??
Date:   Tue, 06 Jul 2021 21:07:33 +0200
In-Reply-To: <20210629134018.62859-1-xypron.glpk@gmx.de> (Heinrich
        Schuchardt's message of "Tue, 29 Jun 2021 15:40:18 +0200")
Message-ID: <877di3mfbe.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Jun 29 2021, Heinrich Schuchardt wrote:

> Requiring that initrd is loaded below RAM start + 256 MiB led to failure
> to boot SUSE Linux with GRUB on QEMU, cf.
> https://lists.gnu.org/archive/html/grub-devel/2021-06/msg00037.html
>
> Remove the constraint.
>
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

With that patch the image in
http://download.opensuse.org/ports/riscv/tumbleweed/iso/ work again.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
