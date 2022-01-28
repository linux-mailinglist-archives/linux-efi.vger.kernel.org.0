Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7799049F2C9
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jan 2022 06:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiA1FQK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jan 2022 00:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiA1FQJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jan 2022 00:16:09 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A379C061714
        for <linux-efi@vger.kernel.org>; Thu, 27 Jan 2022 21:16:09 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i186so2647822pfe.0
        for <linux-efi@vger.kernel.org>; Thu, 27 Jan 2022 21:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xy7V1RKBgPy7ej3aLewZ5fgpZQ6691qdKaJczzqlNHk=;
        b=dvy7Hfy2AHdOXqtC7FdYxoxNBYCQzybLnMezlpbU7QfAVQ94QYX7yYbzPaX4ZM99aa
         JGTaixtkYrNUgotaWxqqyRofLShMxqEjk4rlkyGfzntMnDprBkc5c76+8oDm835SA6Gs
         rL+x0Bkz+dD/OLxKax+lWYebU1P+JkSxNJTT8vrlLwJtOVbzIN5v7OWTnPJBttegPugO
         FV6mPeqs51H88DF5LBRHkc2a+Fhhu0ldsNGOwPi/kk1LWGwO2Nf0sNZXyMYfNU2b735I
         djNR59SP7DmpBilvPJAAqvWfmbCixzOOPSuPHhOiCzHB9ATSCnef3wMrY/NG6KdMbat9
         pdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xy7V1RKBgPy7ej3aLewZ5fgpZQ6691qdKaJczzqlNHk=;
        b=PKMebmCEr+i6IIvlJ89T9kG/MmkPvh+dWI9Fe0OeB+Lppe5x878wuCZgdSc8l0/rwY
         +cJk3lNGzNMY6/CtT+n5VovolsHsxIoEaeknOITE42q6YAfwi3jcGrCY6yuv6w0tgeFR
         o0knzeitOSMpafrh0RlDM+bQmAp0ZMpgRuqAccIWccRTRzPyXyALjE1qojDToxHqs1E2
         s2mjhqIklHx2CeLOd02++7OgHnGzBPvdz4ULj1MaNVPdrCNdm4BJhKb2eBywuHZbf7rT
         MivA+k4b1ZXH0QAACAUfFAZ9uITVSspw3BEMvwd07e1YFMxdviRKMTUc3HOzfeOgQVJy
         8dJA==
X-Gm-Message-State: AOAM533qQnxtHGxui1zlzssCf8xvLEJlGtplnC6RQGJ/y00VnEQEkM+R
        WR3CrHYN88kFgrxg8vJUpBLsQA==
X-Google-Smtp-Source: ABdhPJwcDyOeN54f5ywguadGTIVI8TcNaRt3WmrVCPE7jF6+vI+RUWxhwFLhAJHDtO7JUAZ3sRrvBA==
X-Received: by 2002:a63:f650:: with SMTP id u16mr5337290pgj.2.1643346968484;
        Thu, 27 Jan 2022 21:16:08 -0800 (PST)
Received: from sunil-ThinkPad-T490 ([49.206.3.187])
        by smtp.gmail.com with ESMTPSA id b22sm7617198pfl.121.2022.01.27.21.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 21:16:08 -0800 (PST)
Date:   Fri, 28 Jan 2022 10:46:00 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Abner Chang <abner.chang@hpe.com>,
        Jessica Clarke <jrtc27@jrtc27.com>
Subject: Re: [RFC PATCH 1/1] riscv/efi_stub: Add support for
 RISCV_EFI_BOOT_PROTOCOL
Message-ID: <20220128051600.GB5018@sunil-ThinkPad-T490>
References: <20220126110615.33371-1-sunilvl@ventanamicro.com>
 <20220126110615.33371-2-sunilvl@ventanamicro.com>
 <667AE324-A8D2-41ED-B9DF-62750F3C2574@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <667AE324-A8D2-41ED-B9DF-62750F3C2574@gmx.de>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 27, 2022 at 08:47:35AM +0100, Heinrich Schuchardt wrote:
> Am 26. Januar 2022 12:06:15 MEZ schrieb Sunil V L <sunilvl@ventanamicro.com>:
> >This patch adds the support for getting the boot hart ID in
> >Linux EFI stub using RISCV_EFI_BOOT_PROTOCOL.
> 
> It would be helpful to add a link to the spec in the commit message and maybe a comment that this protocol is needed for the ACPI use case.

Sure. Will add.

> 
> >
> >Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> >---
> > drivers/firmware/efi/libstub/efistub.h    | 15 ++++++++++++
> > drivers/firmware/efi/libstub/riscv-stub.c | 28 ++++++++++++++++++++---
> > include/linux/efi.h                       |  1 +
> > 3 files changed, 41 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> >index edb77b0621ea..0428f8816942 100644
> >--- a/drivers/firmware/efi/libstub/efistub.h
> >+++ b/drivers/firmware/efi/libstub/efistub.h
> >@@ -720,6 +720,21 @@ union efi_tcg2_protocol {
> > 	} mixed_mode;
> > };
> > 
> >+typedef union riscv_efi_boot_protocol riscv_efi_boot_protocol_t;
> >+
> >+union riscv_efi_boot_protocol {
> >+	struct {
> >+		u64 revision;
> >+		efi_status_t (__efiapi *get_boot_hartid)(
> >+							 riscv_efi_boot_protocol_t *,
> >+							 size_t *);
> 
> I prefer to have parameter names for readability

Sure. Will add.

> 
> According to the platform specification mhartid is MXLEN wide. UINTN (size_t) is SXLEN wide. 
> 
> Does this have any implications on how we define the protocol?

I don't think so. EFI and kernel will be at same privilige level. So, it
is not really an issue for this protocol. 

But when MXLEN > SXLEN (ex: 64 vs 32), then implementation need to
ensure hartid value is 32 bit only so that when it is passed from M-mode
firmware to S-mode, it gets correct value. But again this is not an
issue from this EFI protocol perspective.

> 
> >+	};
> >+	struct {
> >+		u32 revision;
> >+		u32 get_boot_hartid;>+	} mixed_mode;
> >+};
> >+
> > typedef union efi_load_file_protocol efi_load_file_protocol_t;
> > typedef union efi_load_file_protocol efi_load_file2_protocol_t;
> > 
> >diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> >index 380e4e251399..c7add4eb5453 100644
> >--- a/drivers/firmware/efi/libstub/riscv-stub.c
> >+++ b/drivers/firmware/efi/libstub/riscv-stub.c
> >@@ -46,12 +46,34 @@ static u32 get_boot_hartid_from_fdt(void)
> > 	return fdt32_to_cpu(*prop);
> > }
> > 
> >+static u32 get_boot_hartid_from_efi(void)
> >+{
> 
> The returned value must be UINTN /size_t like the protocol. This width must be carried to the legacy entry point of Linux.
> 
> >+	efi_guid_t boot_protocol_guid = RISCV_EFI_BOOT_PROTOCOL_GUID;
> >+	efi_status_t status;
> >+	riscv_efi_boot_protocol_t *boot_protocol;
> >+	size_t boot_hart_id;
> >+
> >+	status = efi_bs_call(locate_protocol, &boot_protocol_guid, NULL,
> >+			     (void **)&boot_protocol);
> >+	if (status == EFI_SUCCESS) {
> >+		status = efi_call_proto(boot_protocol,
> >+					get_boot_hartid, &boot_hart_id);
> >+		if (status == EFI_SUCCESS) {
> >+			return (u32)boot_hart_id;
> >+		}
> >+	}
> >+	return U32_MAX;
> 
> U32_MAX is a legal value for the hart id.

Yeah. This is an existing issue in get_boot_hartid_from_fdt() for which
I have sent a fix patch. Once that gets accepted, I will fix
get_boot_hartid_from_efi() and send RFC V2 patch.

> 
> >+}
> >+
> > efi_status_t check_platform_features(void)
> > {
> >-	hartid = get_boot_hartid_from_fdt();
> >+	hartid = get_boot_hartid_from_efi();
> > 	if (hartid == U32_MAX) {
> >-		efi_err("/chosen/boot-hartid missing or invalid!\n");
> >-		return EFI_UNSUPPORTED;
> >+		hartid = get_boot_hartid_from_fdt();
> >+		if (hartid == U32_MAX) {
> 
> U32_MAX is a legal value for the hart id. Please, separate status and value.

Will fix it.

Thank you very much for the feedback.
Sunil

> 
> Best regards
> 
> Heinrich
> 
> >+			efi_err("/chosen/boot-hartid missing or invalid!\n");
> >+			return EFI_UNSUPPORTED;
> >+		}
> > 	}
> > 	return EFI_SUCCESS;
> > }
> >diff --git a/include/linux/efi.h b/include/linux/efi.h
> >index ccd4d3f91c98..9822c730207c 100644
> >--- a/include/linux/efi.h
> >+++ b/include/linux/efi.h
> >@@ -380,6 +380,7 @@ void efi_native_runtime_setup(void);
> > #define EFI_CONSOLE_OUT_DEVICE_GUID		EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4,  0x9a, 0x46, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
> > #define APPLE_PROPERTIES_PROTOCOL_GUID		EFI_GUID(0x91bd12fe, 0xf6c3, 0x44fb,  0xa5, 0xb7, 0x51, 0x22, 0xab, 0x30, 0x3a, 0xe0)
> > #define EFI_TCG2_PROTOCOL_GUID			EFI_GUID(0x607f766c, 0x7455, 0x42be,  0x93, 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
> >+#define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
> > #define EFI_LOAD_FILE_PROTOCOL_GUID		EFI_GUID(0x56ec3091, 0x954c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
> > #define EFI_LOAD_FILE2_PROTOCOL_GUID		EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
> > #define EFI_RT_PROPERTIES_TABLE_GUID		EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
> 
