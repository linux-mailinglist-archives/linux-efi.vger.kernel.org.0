Return-Path: <linux-efi+bounces-1707-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA7E9769ED
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 15:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85DF284826
	for <lists+linux-efi@lfdr.de>; Thu, 12 Sep 2024 13:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959AC1AB52D;
	Thu, 12 Sep 2024 13:03:36 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26AA1AAE1D;
	Thu, 12 Sep 2024 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146216; cv=none; b=hs9dDIJtD++cKDDYzv6V/AzN14FrlRwNd2KuNTBBZEOzTw7+YUAy58a+w6HI8WPj2dsRfA/ThlV/tzsuch3J4c3u4a+Lv71DK9VXurFUJgHsKX8ljgRJEHVb6KBRrFq6AW9FDb/c+AELBI5Hv5HvSVKl5U7Lf5YTzA6kEiej5p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146216; c=relaxed/simple;
	bh=/wD1KPTzQDpIQtFX4qhbxAiy+8aMq7IxhqW8VdszRzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKPRNQB0exrVGgPJkAXvB1o6r9M/i0iRvuU/Qo5XSWG6Clx+x6moO3p8BUyGIrQXkuaG3iA+1l8ihoTnKR6W4aJDBWyvGSAo+sD7GFcbVBA/LWDSOwQtsCHVVPRwohdmCYZBnpOu0dJVVG9eBPuKSJ3y+dmv5N6AYDDgn4qKQkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9018103214so133660266b.3;
        Thu, 12 Sep 2024 06:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726146213; x=1726751013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wD1KPTzQDpIQtFX4qhbxAiy+8aMq7IxhqW8VdszRzc=;
        b=pmUI7Fj966AsQ593t3QRbV8w82SxQL259x+hN816MuZCv2GEIkAYRWWRRH3wBE+Tjz
         hTAz5xn+AvlzhskKLnJAbOkxtPTTm6DjCZpc4y/ZNyusPa3sVbcYmwjXNaxZvkX000qW
         QCWmmOCyPGIR5knLewX6c7S/ihINULJhKWAF1Exws52qdQmDYqApnMVJgSEsmE1ZQuS1
         FeJWler7qztCqwabHVOBBwGrlcJSpni0reUnUpWrR0xfd2IQWkLjWXTC3EqSCbRZEI6a
         IAITdTO4DmFWdLeYzME+3cDH0Z66GlBVb3koYm68wySBACFj5tXf0aviA360ksOq5AfT
         8J+g==
X-Forwarded-Encrypted: i=1; AJvYcCVOrBpsovsSz4vZ8ICvTmNPSXn7V+tML5gAd9ZnSnuXY0MVtbOu9tX4V+a/o731HgXofqmykMt86bc=@vger.kernel.org, AJvYcCWm48tB9wET5xcEYHJjkRfIK8lhjrP9GRmhBqAm3Vs9IgafCu4zJcOFNCXb0J6EadHNuC4UYMPOjVJBEVif@vger.kernel.org
X-Gm-Message-State: AOJu0YylnVsaxrB6BwahbBRPjOFAzJc0qzXKYBu0+r86Lxj0/Pb4QCsa
	s0d5lDHKgnSqPyXSO72DkdoxnlAYTmnX3j2MocsutsnYGq9VEqTi
X-Google-Smtp-Source: AGHT+IEAJDQ4WL7SOl5bsfConzrkXcuMXNQUB3PfItXJ+RTcTlmgoNbZImDHp5Lnh51sPpOpj21bcQ==
X-Received: by 2002:a17:907:7ea1:b0:a86:ae95:eba3 with SMTP id a640c23a62f3a-a9029690d69mr238676866b.62.1726146212358;
        Thu, 12 Sep 2024 06:03:32 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835a76sm746424466b.39.2024.09.12.06.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 06:03:31 -0700 (PDT)
Date: Thu, 12 Sep 2024 06:03:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org,
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com,
	gourry@gourry.net
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
Message-ID: <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>

Hello Ard,

On Thu, Sep 12, 2024 at 12:51:57PM +0200, Ard Biesheuvel wrote:
> I don't see how this could be an EFI bug, given that it does not deal
> with E820 tables at all.

I want to back up a little bit and make sure I am following the
discussion.

From what I understand from previous discussion, we have an EFI bug as
the root cause of this issue.

This happens because the EFI does NOT mark the EFI TPM event log memory
region as reserved (EFI_RESERVED_TYPE). Not having an entry for the
event table memory in EFI memory mapped, then libstub will ignore it
completely (the TPM event log memory range) and not populate e820 table
with it.

Once the e820 table does not have the memory range for TPM event log,
then the kernel is free to overwrite that memory region, causing
corruptions all across the board.

From what I understand from the thread discussion, there are three ways
to "solve" it:

1) Fix the EFI to pass the TPM event log memory as reserved.

2) Workaround it in libstub, and considering the TPM event log memory
range when populating the e820 table. (As proposed in
https://lore.kernel.org/all/2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com/)

3) Workaround in later in the kernel, as proposed in
https://lore.kernel.org/all/20240911104109.1831501-1-usamaarif642@gmail.com/

Please let me know if my understanding is flawed here.

Thank you!
--breno

