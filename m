Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8434016F850
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 08:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgBZHGR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 02:06:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgBZHGR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 26 Feb 2020 02:06:17 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8399824672
        for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2020 07:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582700776;
        bh=uZjWbm4CHv7CzRvbIQoptYI7eFmVZqT/jpXr1XMve3I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZUggyWOdb8O1B4aYP7ECTmUI12PniQXaw4GAhKMCAzyTOVDikA+4CQ7m8IvF/eHYC
         DHylRK4TugMmAsQVorPWYkdc+zKWRBzr/03f52i0+4LXaGj7ngPVi+y4bPx5Q6wvvQ
         gN3avXJRVRrrMK37zeOLogvYyjySaq+75Zjp9HKs=
Received: by mail-wm1-f53.google.com with SMTP id p17so1776015wma.1
        for <linux-efi@vger.kernel.org>; Tue, 25 Feb 2020 23:06:16 -0800 (PST)
X-Gm-Message-State: APjAAAUgIHSwEDOwplp+gPsWvjM1AsZb2wbRCUV+0kmXvWAZQeLxy7Dc
        B4YmQXbpL0qNbMDSXFxXDVx6Lfmhjh8cKEaE9FBmWA==
X-Google-Smtp-Source: APXvYqxVo4pBQodPuVmpIAWoLWlNGgk9OZk/TYLmLgPc/3nUtao5D+GJ3tSM7OyQhzsoCgw/xpZfGvWiOFsuBzM9GRg=
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr216141wmj.1.1582700774936;
 Tue, 25 Feb 2020 23:06:14 -0800 (PST)
MIME-Version: 1.0
References: <20200226011037.7179-1-atish.patra@wdc.com> <20200226011037.7179-3-atish.patra@wdc.com>
In-Reply-To: <20200226011037.7179-3-atish.patra@wdc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Feb 2020 08:06:04 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-LAfcH5mLZNLk7=A3E43a93FK+8DPYNrx1FANnbo3J7g@mail.gmail.com>
Message-ID: <CAKv+Gu-LAfcH5mLZNLk7=A3E43a93FK+8DPYNrx1FANnbo3J7g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] include: pe.h: Add RISC-V related PE definition
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Mao Han <han_mao@c-sky.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Alexander Graf <agraf@csgraf.de>,
        "leif@nuviainc.com" <leif@nuviainc.com>,
        "Chang, Abner (HPS SW/FW Technologist)" <abner.chang@hpe.com>,
        "Schaefer, Daniel (DualStudy)" <daniel.schaefer@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 26 Feb 2020 at 02:10, Atish Patra <atish.patra@wdc.com> wrote:
>
> Define RISC-V related machine types.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

If you put them in alphabetical order wrt SH3:

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


> ---
>  include/linux/pe.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/pe.h b/include/linux/pe.h
> index 8ad71d763a77..6a7c497e4b1f 100644
> --- a/include/linux/pe.h
> +++ b/include/linux/pe.h
> @@ -56,6 +56,9 @@
>  #define        IMAGE_FILE_MACHINE_POWERPCFP    0x01f1
>  #define        IMAGE_FILE_MACHINE_R4000        0x0166
>  #define        IMAGE_FILE_MACHINE_SH3          0x01a2
> +#define        IMAGE_FILE_MACHINE_RISCV32      0x5032
> +#define        IMAGE_FILE_MACHINE_RISCV64      0x5064
> +#define        IMAGE_FILE_MACHINE_RISCV128     0x5128
>  #define        IMAGE_FILE_MACHINE_SH3DSP       0x01a3
>  #define        IMAGE_FILE_MACHINE_SH3E         0x01a4
>  #define        IMAGE_FILE_MACHINE_SH4          0x01a6
> --
> 2.24.0
>
