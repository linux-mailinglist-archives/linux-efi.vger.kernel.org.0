Return-Path: <linux-efi+bounces-2124-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 710749C1CE5
	for <lists+linux-efi@lfdr.de>; Fri,  8 Nov 2024 13:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBFF1F22870
	for <lists+linux-efi@lfdr.de>; Fri,  8 Nov 2024 12:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A601E6DDE;
	Fri,  8 Nov 2024 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cjj0205a"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B67B3E1
	for <linux-efi@vger.kernel.org>; Fri,  8 Nov 2024 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068789; cv=none; b=NjNX31xdKZ8PNAPZWdDPO8NDJXOfIRcWgNg2+Q7ca5a6BIVFv2Q6g2f8f1Nh2bbSVmVGJYj77u+W4FWsCIyMn+B5h6g683+bHyDAHwE2NyHU9YCyjdfoTDTWBfvocObTD4biZBf3ofwrT/Pgln3tm1wck1podHqorW/DUxmZyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068789; c=relaxed/simple;
	bh=bRCGf/Wgy4FWDjxjm3445qpC2UR9lA5sk1A8y9SMWRI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dWZ/SMQeaVJ/7kEv9Rx7mv3b0D+rN7JOYZm6CzEq7EuOLxDjtWqC699mZE/P+PiWmmqY6sGxzRMedwkyUCG3FcyoM3cGxkvhSyYiQmO5+hX8wVrhtyLeKk0uIwXL84ubLBwzx0LVnxbGXkp0ChAjC+cR3cVSFUdWDch26qf0Ycc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cjj0205a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731068785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=zXwAvU705aOAOAu5VxWMi2RxSodq3/VIqQ5cCCgEPB4=;
	b=Cjj0205aVIU/y1opilXowBQvUuu1B4pHgi2TmqFomlIKHhoaHS15M+BVqSeSkDx80f1tEM
	wd4U/kcl2wrykZ2ZtpyqMgUfCZ8kah82oB4vgD87HhDbg6FQ5N7wQoSIFQ2xIlunBEkG/M
	aXNnwndr7KPfjlas81dkT/xjmmviVNg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-ZqQ_-GTAMnCMj0x4MHry7g-1; Fri, 08 Nov 2024 07:26:23 -0500
X-MC-Unique: ZqQ_-GTAMnCMj0x4MHry7g-1
X-Mimecast-MFC-AGG-ID: ZqQ_-GTAMnCMj0x4MHry7g
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3df19f2433cso171256b6e.3
        for <linux-efi@vger.kernel.org>; Fri, 08 Nov 2024 04:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731068783; x=1731673583;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zXwAvU705aOAOAu5VxWMi2RxSodq3/VIqQ5cCCgEPB4=;
        b=Z1w17SlzjKXvljyXjlUavm5kWss9HQCvm5xp9JuMolLzVatiphtRluq0jY4ljkGmwI
         V+kkl4vq9a2Lv1dUtteyMNm7b2w5hJoxmE/5Uh1x38MUhH0ZMl7d9blrqPXYRozXoGjI
         dR12sKMe6ci/2U1N9iOpFCH16jkxM8P2/1C1a91jigTxr/7369CHBRpCVu5GSEH1lCig
         TjjwqJx3ZjQLuBHyNeo4Q5Qk+N+onGooFByBN7Qn6WZYaz6f/S8wuZxC1iJo3wGMbR8s
         tsgwHJB/SlNeGwwLSL5JFS9DJoASeDGPIa2AtKrQDr8+7bFzpwAU+gc2m8cy8mjnTsip
         V5uw==
X-Forwarded-Encrypted: i=1; AJvYcCVuUmnny8G70kLKo2TlPcTIgv6LO1Efbylat0Ds605r+w44A5Lu7yafygN41Q3NRYPXQhffknpvvMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSyllhl4iIkMNx6ynHrbQnzfDSaIZCy4mVySzyObtDLHVk8NUy
	59fFMCM6/2lKcX3lCo4rN7KD555UveNv1feFjLgJuqVmHF2s6VkYHkiDzFe/f7hW6Lod4M7R0lx
	mhPBgwP99aCKkn4N+ZrDEXUG/qV/IiOw1QpLOaVHnbHB3JXJJi2cGP/PaVB4XBRlX33ss2vU3ds
	L2Mdwq3luEUbbzuuoAoKz31bxaIxpaf9oo
X-Received: by 2002:a05:6808:bd6:b0:3e6:49e0:f16b with SMTP id 5614622812f47-3e79464ffbemr561214b6e.1.1731068783035;
        Fri, 08 Nov 2024 04:26:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDh9xZLbDlbWxWwt0Ee/VQnmLbaHr7eXwqcgUZluZ+iMr9vgrajudEgifQ9sAYdMtcBXTBSmyV5BbZCxOsCjU=
X-Received: by 2002:a05:6808:bd6:b0:3e6:49e0:f16b with SMTP id
 5614622812f47-3e79464ffbemr561207b6e.1.1731068782692; Fri, 08 Nov 2024
 04:26:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Fri, 8 Nov 2024 13:26:12 +0100
Message-ID: <CALE0LRvJ-n77oU=O9__NdSLw2v33zMK+WYkn2LcwWMwHCbohQw@mail.gmail.com>
Subject: optee-based efi runtime variable service on TI j784s4 platforms
To: Ard Biesheuvel <ardb@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Masahisa Kojima <masahisa.kojima@linaro.org>, 
	linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Manorit Chawdhry <m-chawdhry@ti.com>, Udit Kumar <u-kumar1@ti.com>, "Menon, Nishanth" <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'm looking for any advice/clue to help me to progress on enabling
TEE-base EFI Runtime Variable Service on TI a j784s4 platforms.

I basically followed the steps described in u-boot documentation [1],
I enabled some debugging messages but I think I'm at the point that
the problem might be in the StandaloneMM application, and I'm not sure
how to debug it.

What I see is that when I run the tee-supplicant daemon, it looks like
the tee_client_open_session() call loops forever and the tee_stmm_efi
driver never ends to probe.

With debug enabled I got the following messages.

# tee-supplicant
D/TC:? 0 tee_ta_init_session_with_context:557 Re-open trusted service
7011a688-ddde-4053-a5a9-7b3c4ddf13b8
D/TC:? 0 load_stmm:297 stmm load address 0x40004000
D/TC:? 0 spm_handle_scall:859 Received FFA version
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request

And tracing the function calls gives me that:

      tee_stmm_efi_probe() {
             tee_client_open_context() {
               optee_get_version() {
                 tee_get_drvdata(); (ret=0xffff000002e55800)
               } (ret=0xd)
               tee_ctx_match(); (ret=0x1)
               optee_smc_open() {
                 tee_get_drvdata(); (ret=0xffff000002e55800)
                 optee_open() {
                   tee_get_drvdata(); (ret=0xffff000002e55800)
                 } (ret=0x0)
               } (ret=0x0)
             } (ret=0xffff000004e71c80)
             tee_client_open_session() {
               optee_open_session() {
                 tee_get_drvdata(); (ret=0xffff000002e55800)
                 optee_get_msg_arg() {
                   tee_get_drvdata(); (ret=0xffff000002e55800)
                   tee_shm_get_va(); (ret=0xffff000002909000)
                 } (ret=0xffff000002909000)
                 tee_session_calc_client_uuid(); (ret=0x0)
                 optee_to_msg_param(); (ret=0x0)
                 optee_smc_do_call_with_arg() {
                   tee_get_drvdata(); (ret=0xffff000002e55800)
                   tee_shm_get_va(); (ret=0xffff000002909000)
                   tee_shm_get_va(); (ret=0xffff000002909060)
                   optee_cq_wait_init(); (ret=0xffff000002e55910)
                   optee_smccc_smc(); (ret=0xffff0004)
                   tee_get_drvdata(); (ret=0xffff000002e55800)
                   optee_smccc_smc(); (ret=0xffff0004)
                   tee_get_drvdata(); (ret=0xffff000002e55800)
                   optee_smccc_smc(); (ret=0xffff0004)
                   tee_get_drvdata(); (ret=0xffff000002e55800)
                   optee_smccc_smc(); (ret=0xffff0004)
                   tee_get_drvdata(); (ret=0xffff000002e55800)
                   optee_smccc_smc(); (ret=0xffff0004)
     ... continues sending this forever ...
     ... Hit ^C to stop recording ...
                   tee_get_drvdata(); (ret=0xffff000002e55800)
                   optee_smccc_smc() {

[1] https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#using-op-tee-for-efi-variables

Thanks in advance,
   Enric


