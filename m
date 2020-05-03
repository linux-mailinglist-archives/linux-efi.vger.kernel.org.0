Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3AC1C2D3B
	for <lists+linux-efi@lfdr.de>; Sun,  3 May 2020 17:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgECPJJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 3 May 2020 11:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgECPJJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 3 May 2020 11:09:09 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05A5C061A0E;
        Sun,  3 May 2020 08:09:08 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t9so2571199pjw.0;
        Sun, 03 May 2020 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RQ4xQUOUYU1ceGWYZbAOlK79wRaKTSufpi1Gmn5srvE=;
        b=HHxCS3h0tCUtMIpNqidypzzKNVbIg4HTknvVTUhXOOFToBYuJjy5fuaKgJytnyXvhw
         wPPFOdwwDTAHPb9hlfGaVte38apN/7r0EwGrPL94UZ5iAvdiqpMvHE1ESqdP6mEK05i1
         L4smFhld6gwL7d1Dx3Ylc8D0PcTJXGjD1xME5y8C0IZIhyU2SF8ijK72e9mK4u5CYHMV
         nDu0CEAqK/7Zckq/eMIv5Az7t1V40SZ0b+zWO5wl8hEQhrzPlSq3qM4ZprVjsZql22FN
         lsZWJ3Rcz4frSEKjcJLqlXxGbcT2bomS7og1SNcnJwCtOQmrDotUOKABM/hqWCVavDGA
         QGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RQ4xQUOUYU1ceGWYZbAOlK79wRaKTSufpi1Gmn5srvE=;
        b=B9o+QHs1uCjtgzhQouZGIZ5mt6ZArlB+89S2sKpH5WMufqns7kXypvd+u2JHq1GGtl
         s+cRgeaUAqr/VstFqtn4pCaF/HHqAfVfRY+3hF79B636XkI8/axCeZgvw7ASfvIhfPU2
         2lmcX0SSZr3FpympxxuwFIIfHKnpWdyUFtTwEh5pj7dwq3weBakadk0AqjK3ZvYRzV1f
         wNr8qY5aUVxos1Q2akl1tEGTqEklWXaAM/IlNggt5s33dVJPDsBmflTbzpzBXTpjY299
         UAA9CA5peftDuwQ564m/DKs4zdCKQhSvx1nNBmquG1xDsN7pKRrp7ZtykEqURRkg0aSH
         ClxQ==
X-Gm-Message-State: AGi0PuajpLRFgcRxWWxQD4VL40seN/bhP+W5g2VlOblNp6YdqpjMD+tW
        K671ZTFDDI57whVJt1rTgAs=
X-Google-Smtp-Source: APiQypJGZ93YHeSypddIUZP/4UQ1paeTkCVIcHTsPPrd0xrTLyo3Bk+T4hlWFt7ruAIhypS4ZsMYhg==
X-Received: by 2002:a17:90a:1912:: with SMTP id 18mr12211496pjg.115.1588518548356;
        Sun, 03 May 2020 08:09:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cv21sm4584481pjb.23.2020.05.03.08.09.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 May 2020 08:09:07 -0700 (PDT)
Date:   Sun, 3 May 2020 08:09:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: Re: [PATCH 03/33] efi/libstub: Unify EFI call wrappers for non-x86
Message-ID: <20200503150906.GA57805@roeck-us.net>
References: <20200424130531.30518-1-ardb@kernel.org>
 <20200424130531.30518-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424130531.30518-4-ardb@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On Fri, Apr 24, 2020 at 03:05:01PM +0200, Ard Biesheuvel wrote:
> We have wrappers around EFI calls so that x86 can define special
> versions for mixed mode, while all other architectures can use the
> same simple definition that just issues the call directly.
> In preparation for the arrival of yet another architecture that doesn't
> need anything special here (RISC-V), let's move the default definition
> into a shared header.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

This patch causes an immediate reboot in linux-next when booting
in qemu with an efi32 bios. Bisect log attached.

Qemu command line:

qemu-system-x86_64 -kernel arch/x86/boot/bzImage -m 1G \
	-no-reboot -snapshot \
	-bios OVMF-pure-efi-32.fd \
	-drive file=rootfs.ext2,format=raw \
	--append 'earlycon=uart8250,io,0x3f8,9600n8 panic=-1 root=/dev/sda console=ttyS0' \
	-nographic

The same command succeeds with OVMF-pure-efi-64.fd.

Bisect log attached.

File locations:
	https://github.com/groeck/linux-build-test/blob/master/rootfs/firmware/OVMF-pure-efi-32.fd
	https://github.com/groeck/linux-build-test/blob/master/rootfs/x86_64/rootfs.ext2.gz

Guenter

---
# bad: [fb9d670f57e3f6478602328bbbf71138be06ca4f] Add linux-next specific files for 20200501
# good: [6a8b55ed4056ea5559ebe4f6a4b247f627870d4c] Linux 5.7-rc3
git bisect start 'HEAD' 'v5.7-rc3'
# good: [068b80b68a670f0b17288c8a3d1ee751f35162ab] Merge remote-tracking branch 'drm/drm-next'
git bisect good 068b80b68a670f0b17288c8a3d1ee751f35162ab
# bad: [46c70fc6a3ac35cd72ddad248dcbe4eee716d2a5] Merge remote-tracking branch 'drivers-x86/for-next'
git bisect bad 46c70fc6a3ac35cd72ddad248dcbe4eee716d2a5
# good: [3fc893798e1ca8276eaf2b0e3210f2ff927f0c80] Merge remote-tracking branch 'integrity/next-integrity'
git bisect good 3fc893798e1ca8276eaf2b0e3210f2ff927f0c80
# bad: [88188475d4d3fd10edabb172a7dc71e4bf997c19] Merge remote-tracking branch 'tip/auto-latest'
git bisect bad 88188475d4d3fd10edabb172a7dc71e4bf997c19
# good: [a51a8decbc07a511d9a05b2aff93bd8b10bfe812] Merge branch 'objtool/core'
git bisect good a51a8decbc07a511d9a05b2aff93bd8b10bfe812
# good: [12414a49ebe9d6584f4942a4bfd98ce5c34e034b] Merge remote-tracking branch 'spi/for-next'
git bisect good 12414a49ebe9d6584f4942a4bfd98ce5c34e034b
# good: [703b321501c95c658275fd76775282fe45989641] kcsan: Introduce ASSERT_EXCLUSIVE_BITS(var, mask)
git bisect good 703b321501c95c658275fd76775282fe45989641
# bad: [e71356fe29e7bd5cd5e07800d4940a7481fb0854] efi/libstub/arm64: Switch to ordinary page allocator for kernel image
git bisect bad e71356fe29e7bd5cd5e07800d4940a7481fb0854
# bad: [9867fc9de6a6a7a54edb2c43540c6db226e84a14] efi/gop: Use helper macros for find_bits
git bisect bad 9867fc9de6a6a7a54edb2c43540c6db226e84a14
# bad: [8cd207973c37175bf44727e28aa9c74fcf18de5e] efi/gop: Move check for framebuffer before con_out
git bisect bad 8cd207973c37175bf44727e28aa9c74fcf18de5e
# bad: [22090f84bc3f8081e0ec180ccaedc85820085376] efi/libstub: unify EFI call wrappers for non-x86
git bisect bad 22090f84bc3f8081e0ec180ccaedc85820085376
# good: [cf6b83664895a5c7e97710df282e220bd047f0f5] efi/libstub: Make initrd file loader configurable
git bisect good cf6b83664895a5c7e97710df282e220bd047f0f5
# first bad commit: [22090f84bc3f8081e0ec180ccaedc85820085376] efi/libstub: unify EFI call wrappers for non-x86
