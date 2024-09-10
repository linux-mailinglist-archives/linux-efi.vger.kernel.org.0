Return-Path: <linux-efi+bounces-1691-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B600F973933
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 15:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F22BEB22CCC
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 13:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55C8192D60;
	Tue, 10 Sep 2024 13:58:51 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209C218CBE0
	for <linux-efi@vger.kernel.org>; Tue, 10 Sep 2024 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725976731; cv=none; b=k1BOpgEylGnUUDbMLHVofZ6SPszPed87+RYd2+mPv3WfnWWKsMrjmdHwme9+gj30XCz2dj2VmaJvifzX69JvzCeFRYOZeUx1n1ZSd3yhyZkGbF2boZWwRFMHM/czXyOa4i90dmM4Q0Gd1CPTNZihOvsu/JGPWWyrIC2iqWiY0jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725976731; c=relaxed/simple;
	bh=bkDvHm5EBdiBTdjt08qWdfm63p48PLEGx94epGOUYbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R8QKaDWlf8VnHfnps/6v9+xq8KBeML0LXHIfZ4ZNMVQ9eSouUK8J1XTWczPdBFjfdqJEBk9eJb/D/yOKToxDhCsAEWL6510vwcsd+8e6A3ve7+8pWSwsQ/4yBmm2dcaUHjXSV36fk74X7D7kqayRJbitr7imBvvqHfO6Vt1cwWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53653682246so1003908e87.1
        for <linux-efi@vger.kernel.org>; Tue, 10 Sep 2024 06:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725976728; x=1726581528;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgIpDVcWYMf0vuk5YN9yMPDXZSWDvspzC2nEKP5HOCI=;
        b=PAyh9rdD5GscnETY//Xh0aPf8RtN6XtAOp0fpkTbchfJR3vMvRJfTxm5w0IMku4EB4
         4CvK/EWp7jH4jti85Emw2RMexhgChZKbJbC0GpgQU0o1TvgXdaAyEKle7HkEsQxvQ7v0
         FE+F2GeGpr6ICXjq23mPIdVmUN+QtLP/IqFfHFht1Qa5XGAlda/fOkMrydDzmdkX1i5C
         5mo5GOxTNp9bpjaZiKmOZYdCcGOUYgoC358xztl6lyXu5LBN63cSQEEkuxZIMw0Dnbcf
         T5uRn6P7ywdkR2hSfBqmx4lriGuvmOXAxjnDaYjmAl5JtUqgADIQlmpx5OWwMhedFRsZ
         YO5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUu0wHTYR4ZvZDyO0KalNzea/KiuirGI08aByrZv21ZJkW8e7O9qWRmrarxi3DVGKyegKCOjywO6/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWjdLja2eO47NTpBk8RVxCOSZRG7LTPRTx2wjiFiOApTEhnCKq
	Mda3V2iTmXWK7sMuH7vF9xx0QAjxarna3KjxBp3N0aY0eLLJsZU/
X-Google-Smtp-Source: AGHT+IHhEuv8mrvn4438U00xZWueYNo2K4Ra1vZJaFUb6cxmb836Wz2QI3yrmjwC9AzNyQBdfgDXfg==
X-Received: by 2002:a05:6512:2215:b0:530:e228:7799 with SMTP id 2adb3069b0e04-53658813717mr11032307e87.58.1725976727247;
        Tue, 10 Sep 2024 06:58:47 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2593cffcsm486589666b.55.2024.09.10.06.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 06:58:46 -0700 (PDT)
Date: Tue, 10 Sep 2024 06:58:44 -0700
From: Breno Leitao <leitao@debian.org>
To: ardb@kernel.org, linux-efi@vger.kernel.org, kexec@lists.infradead.org,
	bhe@redhat.com, vgoyal@redhat.com, devel@edk2.groups.io,
	ebiederm@xmission.com
Cc: rppt@kernel.org, usamaarif642@gmail.com, gourry@gourry.net,
	rmikey@meta.com
Subject: EFI table being corrupted during Kexec
Message-ID: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


We've seen a problem in upstream kernel kexec, where a EFI TPM log event table
is being overwritten.  This problem happen on real machine, as well as in a
recent EDK2 qemu VM.

Digging deep, the table is being overwritten during kexec, more precisely when
relocating kernel (relocate_kernel() function).

I've also found that the table is being properly reserved using
memblock_reserve() early in the boot, and that range gets overwritten later in
by relocate_kernel(). In other words, kexec is overwriting a memory that was
previously reserved (as memblock_reserve()).

Usama found that kexec only honours memory reservations from /sys/firmware/memmap
which comes from e820_table_firmware table.

Looking at the TPM spec, I found the following part:

	If the ACPI TPM2 table contains the address and size of the Platform Firmware TCG log,
	firmware “pins” the memory associated with the Platform Firmware TCG log, and reports
	this memory as “Reserved” memory via the INT 15h/E820 interface.


From: https://trustedcomputinggroup.org/wp-content/uploads/PC-ClientPlatform_Profile_for_TPM_2p0_Systems_v49_161114_public-review.pdf

I am wondering if that memory region/range should be part of e820 table that is
passed by EFI firmware to kernel, and if it is not passed (as it is not being
passed today), then the kernel doesn't need to respect it, and it is free to
overwrite (as it does today). In other words, this is a firmware bug and not a
kernel bug.

Am I missing something?

Thanks
--breno

