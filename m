Return-Path: <linux-efi+bounces-3829-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C4FAD6CDE
	for <lists+linux-efi@lfdr.de>; Thu, 12 Jun 2025 11:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09ADF17B43B
	for <lists+linux-efi@lfdr.de>; Thu, 12 Jun 2025 09:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B647E22FF37;
	Thu, 12 Jun 2025 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="tDJJkjCS"
X-Original-To: linux-efi@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BB222D9ED;
	Thu, 12 Jun 2025 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749722298; cv=none; b=rg74puPt14FCE24/z0GzDuCAKw0b/4fPSyWc1lkfP6Qv0XN4Pn6RUxkW7AliBMwnjCNkauDS62OOrf3/tXXUz3VHekWEvD1HHZ2cPm9SGGJ4r6JINlrw0PTOxwt+60Oi1dgzirNJyod8pqNeYdb3Qj08kNYZecOw0R+U8Zq0Z5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749722298; c=relaxed/simple;
	bh=5lm3CROQoCKhao5Ca1yh00q3aQ56aGBHBbVoD/37i5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aep6nx+HiXaeP7DVpy+gRxz8M311au0h4TdiEQ4Q2vyWinogz1umqlybWn27+my1Z05PYxFjmqSJylBmeXFZ2dU2EAv3+YGb4ZF7kBCxnFaqz/d5Y4QthUkbBLbkTjj4rJBtSjik9dEzdlMWlrK9b0ZA0McCUqair4WVf6NRvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=tDJJkjCS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.224.160] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 91B9A201C768;
	Thu, 12 Jun 2025 02:57:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 91B9A201C768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749722295;
	bh=eV3A+ddBcibHRVaqFJxwXvFIGtWcCdCwh7KjLBme/sQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tDJJkjCSRPy1hYNPAJtUISF1WSrCFZjdUEcEOdGWKAqv01iv5hJcEcllquwSVNAjF
	 q6us+/HaBIBYi1tNhaYqZ9/ZpX81sTqUj9rNVlp0pkdgFUWydBJs/cT+uNCqPNoGR6
	 7cUs3sg09Mbn3wLax4jFUWttwF/QfkOeeZy88ftA=
Message-ID: <42abc705-bdb5-4be0-9fe7-b49d0a0d9507@linux.microsoft.com>
Date: Thu, 12 Jun 2025 15:27:55 +0530
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: Fix build warnings about export.h
To: Zhenghan Cheng <chengzhenghan@uniontech.com>,
 herbert@gondor.apana.org.au, davem@davemloft.net, peterz@infradead.org,
 acme@kernel.org, namhyung@kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 rafael@kernel.org, jgross@suse.com, Jason@zx2c4.com, mhiramat@kernel.org,
 ebiggers@kernel.org, masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, lenb@kernel.org,
 ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, ppaalanen@gmail.com,
 boris.ostrovsky@oracle.com, nathan@kernel.org, nicolas@fjasle.eu,
 ilpo.jarvinen@linux.intel.com, usamaarif642@gmail.com, ubizjat@gmail.com,
 dyoung@redhat.com, myrrhperiwinkle@qtmlabs.xyz, guoweikang.kernel@gmail.com,
 graf@amazon.com, chao.gao@intel.com, chang.seok.bae@intel.com,
 sohil.mehta@intel.com, vigbalas@amd.com, aruna.ramakrishna@oracle.com,
 zhangkunbo@huawei.com, fvdl@google.com, gatlin.newhouse@gmail.com,
 snovitoll@gmail.com, bjohannesmeyer@gmail.com, glider@google.com,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 shivankg@amd.com, peterx@redhat.com, dan.j.williams@intel.com,
 dave.jiang@intel.com, kevin.brodsky@arm.com, willy@infradead.org,
 linux@treblig.org, Neeraj.Upadhyay@amd.com, wangyuli@uniontech.com,
 linux-crypto@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
 Zhenghan Cheng <your_email@example.com>
References: <20250612093021.7187-1-chengzhenghan@uniontech.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20250612093021.7187-1-chengzhenghan@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/12/2025 3:00 PM, Zhenghan Cheng wrote:
> After commit a934a57a42f64a4 ("scripts/misc-check:
> check missing #include <linux/export.h> when W=1")
> and commit 7d95680d64ac8e836c ("scripts/misc-check:
> check unnecessary #include <linux/export.h> when W=1"),
> we get some build warnings with W=1,such as:
> 
> arch/x86/coco/sev/core.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> arch/x86/crypto/aria_aesni_avx2_glue.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> arch/x86/kernel/unwind_orc.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> arch/x86/kvm/hyperv.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
> arch/x86/events/intel/core.c: warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present
> arch/x86/events/zhaoxin/core.c: warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present
> arch/x86/kernel/crash.c: warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present
> arch/x86/kernel/devicetree.c: warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is present
> 
> so fix these build warnings for x86.
> 
> Signed-off-by: "Zhenghan Cheng" <chengzhenghan@uniontech.com>
> Suggested-by: "Huacai Chen" <chenhuacai@loongson.cn>
> 


Thanks for sharing.

FYI, I sent a patch to fix these warnings in Hyper-V related drivers
here:
https://lore.kernel.org/all/20250611100459.92900-1-namjain@linux.microsoft.com/

Some of the files are common to the ones in your patch.

Regards,
Naman



