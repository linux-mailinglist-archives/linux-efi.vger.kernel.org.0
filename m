Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630B61B302A
	for <lists+linux-efi@lfdr.de>; Tue, 21 Apr 2020 21:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgDUTTi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Apr 2020 15:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgDUTTh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Apr 2020 15:19:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C92EC0610D5
        for <linux-efi@vger.kernel.org>; Tue, 21 Apr 2020 12:19:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id q18so3692905pgm.11
        for <linux-efi@vger.kernel.org>; Tue, 21 Apr 2020 12:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=oG8/M8woClgdZByQ4O0E/sOcIdtjW+AdEaBy+B1gN2c=;
        b=AE1lJjfPrNEBUOYdWiCl8AoGLwLDSjR6b43Tas4kfrYBr91FLcFaylMPHmW9WtF7n5
         Wyapka3xYfcMFhW9Q86ERqgqqS7TOu37qqMROcTI8dCMF6wZiBjcn+GXxpEOkfTnQ1ON
         E6BC/n9lC7YKuwIC09EyR8/mxVpLBY+9eda6+jK9AaCfFYRtNZV/AR/rUFw3fgT3iYd2
         H3X70fZx9YPnPPb0nBiOvSEArc8AL3dxv6SkSGKfwQdJiHgXuHRNPKZibTG1CjnTfjbR
         ykaRT22ozu6rxEj+9wnDwF6LewajfdoeptzROI5Y4j0YGetJ5H8bkuW9/c1VytryMvXC
         icow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=oG8/M8woClgdZByQ4O0E/sOcIdtjW+AdEaBy+B1gN2c=;
        b=le+ElPp5sTM24EM3zcWUiJMUBbJNcAE1Jtk6VDRqK6Q0crlIpXemfAstGEtivaYB7G
         AsthseSdrN+ejCoI8HvcpMEK9AAuuRUI8WoTQkSRreDP97wZUwtcM4HvVGdMjtoA+d9k
         nvFjfwOUGPUPyxJO3fou0CS3gXmby96kjBiQ9jNW/Ihg5ahFbafbhpt+LuHzgyoYbrG4
         u4fqa3mIC1MbkLnyossaIuDivb7+nbamDIATnT/diu30b5Oq0VQlIWf8e7sd86A0g3BR
         wTFDeCUS8CDCl5Vl55n99JLnh+RViT+fqhlppLM5HRG/qs0zYK9dzQaYTB6Pj9FzrvTe
         rhWg==
X-Gm-Message-State: AGi0PuZSgOtJ7rzoVKhZsas/7KmI7kflDpxfoYUPQqDyx0SE/H7AQ20C
        KhD/itcMFpFOPO0vPwbR6FzLuA==
X-Google-Smtp-Source: APiQypJ/Wrm6B2FLtfVVw+YdN1C75/RC3kUuQvbW1PXYG5G44AxbRXujl+Rk6VUE5R73VKINuh8xaQ==
X-Received: by 2002:a65:6403:: with SMTP id a3mr23843368pgv.222.1587496776634;
        Tue, 21 Apr 2020 12:19:36 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x63sm3144542pfx.122.2020.04.21.12.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 12:19:35 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:19:35 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Apr 2020 12:16:14 PDT (-0700)
Subject:     Re: [v2 PATCH 2/5] include: pe.h: Add RISC-V related PE definition
In-Reply-To: <20200413212907.29244-3-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        ardb@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        catalin.marinas@arm.com, Greg KH <gregkh@linuxfoundation.org>,
        mingo@kernel.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, masahiroy@kernel.org,
        linux@armlinux.org.uk, will@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-6abd4389-d713-452c-9b62-5c0d3ed2d936@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 13 Apr 2020 14:29:04 PDT (-0700), Atish Patra wrote:
> Define RISC-V related machine types.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  include/linux/pe.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/pe.h b/include/linux/pe.h
> index 8ad71d763a77..daf09ffffe38 100644
> --- a/include/linux/pe.h
> +++ b/include/linux/pe.h
> @@ -55,6 +55,9 @@
>  #define	IMAGE_FILE_MACHINE_POWERPC	0x01f0
>  #define	IMAGE_FILE_MACHINE_POWERPCFP	0x01f1
>  #define	IMAGE_FILE_MACHINE_R4000	0x0166
> +#define	IMAGE_FILE_MACHINE_RISCV32	0x5032
> +#define	IMAGE_FILE_MACHINE_RISCV64	0x5064
> +#define	IMAGE_FILE_MACHINE_RISCV128	0x5128
>  #define	IMAGE_FILE_MACHINE_SH3		0x01a2
>  #define	IMAGE_FILE_MACHINE_SH3DSP	0x01a3
>  #define	IMAGE_FILE_MACHINE_SH3E		0x01a4

I'm reading "Unified Extensible Firmware Interface (UEFI) Specification Version
2.8 Errata A" and see all this

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
