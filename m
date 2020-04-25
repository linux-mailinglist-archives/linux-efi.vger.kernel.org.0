Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6D61B84A5
	for <lists+linux-efi@lfdr.de>; Sat, 25 Apr 2020 10:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgDYI1w (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 Apr 2020 04:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgDYI1v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 25 Apr 2020 04:27:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527D6C09B049;
        Sat, 25 Apr 2020 01:27:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 188so13723585wmc.2;
        Sat, 25 Apr 2020 01:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vMBU0L0/3fjLTfHhdrcWbEXhAP+cf7eZvOROQfo8OYc=;
        b=Xan1j3dBQ7bpoPLhuzN0q5celmdqsZVqOY0VEBWHzyh2ND0WVK9Ct4UPEwNrLDf1HS
         DbLjk0C9rgjJWaIuqgmDEXdA9wAWpcbj1gkTWEk7ztC+hrTIvY6hIbrgtJk2HLgL5Hl0
         BCBNSHXNcFT3sfFoiLeX0BZ01Grj09bexb8f8RKmgzGlI4hGg0SPrdoUyBD7VLpGvPet
         sZXRa+qz8KUUUbGdk4uKMVsJB6w1ZxyqGTQfK6pHS498YdhFMqltgApXAwtMXB/VwjUO
         MqmRy+vEuwhh35pyqkBszZoEqYRLJnsQFd2ZoBcQo3fSb5D8Cj1HlaztbCtSEl+pkR6e
         K3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vMBU0L0/3fjLTfHhdrcWbEXhAP+cf7eZvOROQfo8OYc=;
        b=bQCJkwtKzYIjRn3j76f3UoZ0jxxeh9iKyjJyhKyOlb4YMP40uMMLY0L+fRM8ajQBzZ
         t127fuUgmdgINMMuasGwOMmBT9aRwZH2//f9SYBvkmfvP3KV6bz+05/Xwe1iql4ddB95
         JheCthweYIrdddUVp29QlS7PwFosR3hGGD0otELHK5r3J38Kdy0/btHw9VfeNCLbW7Tt
         a6B47zFuSCdmkpOdimO3OiHZ+bTH5boFFTKQhhzIuioMIU07HU+4kQZdeWpgzZZhTmcj
         H1OJxMyB1hQII1tccv2dVHMPX/URyDdJxeBpApo1GO6/xSOJSufiMNePgeEQoVDVA9NE
         vDvg==
X-Gm-Message-State: AGi0PuZOf2drJRhsSid0Tj/2q6F34netOWTyjxgOym+SBm6qyeH8LjE9
        03UYgDE2ZIs2nk/Kdoz6VGU=
X-Google-Smtp-Source: APiQypKmZ4FfTNjAy1ifPc9mJKqKeP5L+T6iOKBy5n9gJC5Is2bdI+K5sgGZFxYLKaPxQs/gQ5C74w==
X-Received: by 2002:a1c:c2d6:: with SMTP id s205mr15560652wmf.90.1587803270043;
        Sat, 25 Apr 2020 01:27:50 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id a9sm5835809wmm.38.2020.04.25.01.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 01:27:49 -0700 (PDT)
Date:   Sat, 25 Apr 2020 10:27:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: Re: [GIT PULL 00/33] EFI updates for v5.8
Message-ID: <20200425082747.GA94804@gmail.com>
References: <20200424130531.30518-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424130531.30518-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> Hello Ingo, Thomas,
> 
> Please pull the attached changes into tip/efi/next. There is some
> coordination going on with the RISC-V tree this time, so please take the
> patches in this exact order, and apply them onto v5.7-rc2 so the first
> three patches can serve as a shared stable base between the efi/core
> branch and the riscv tree.
> 
> The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:
> 
>   Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next
> 
> for you to fetch changes up to 4eb8320bd1aaa7e69d039f2c251735e3ef0b9a38:
> 
>   efi: Move arch_tables check to caller (2020-04-24 14:52:16 +0200)
> 
> ----------------------------------------------------------------
> EFI changes for v5.8:
> - preliminary changes for RISC-V
> - add support for setting the resolution on the EFI framebuffer
> - simplify kernel image loading for arm64
> - Move .bss into .data via the linker script instead of relying on symbol
>   annotations.
> - Get rid of __pure getters to access global variables
> - Clean up the config table matching arrays

>  27 files changed, 895 insertions(+), 574 deletions(-)
>  create mode 100644 drivers/firmware/efi/libstub/alignedmem.c
>  rename drivers/firmware/efi/libstub/{arm-stub.c => efi-stub.c} (96%)
>  create mode 100644 drivers/firmware/efi/libstub/relocate.c

Pulled into tip:efi/core, thanks a lot Ard!

	Ingo
