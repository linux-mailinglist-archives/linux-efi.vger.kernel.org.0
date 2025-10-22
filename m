Return-Path: <linux-efi+bounces-5092-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88748BFE68C
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 00:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338D43A32FB
	for <lists+linux-efi@lfdr.de>; Wed, 22 Oct 2025 22:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1857B304BCB;
	Wed, 22 Oct 2025 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWU2utV9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4041F2D739C
	for <linux-efi@vger.kernel.org>; Wed, 22 Oct 2025 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171945; cv=none; b=OvZpgYkWtF7MQuXT6YvFVjRmPb4WjGAM+yVGL8Z1SkaXAntXQymlMJroTv43RYfuaenStvXsVS6XCS9GJCVNQ1n9Wd5Qze6H3vsOs6kKQHWMfKuLDR3Qv8ldhNaSXS+huRoQbjaqISjeFqA/XiqOwBsGaESkBr/91jbazSqqrgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171945; c=relaxed/simple;
	bh=OTzSMtI2oah5TUoqQlw4qmVkuwni1f0orsjuIeP59hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oC04tnUqMEzubwIkoBxITLSufjjLCTEEsEjDF8cACmJfFaA0uc1nLOiTEhmMdMA7LQKjwngwOwmKATs3gfFN8CKO+TKEJbHHXIokq0ywj+8ogFDw00HLHN49nB022U9IibBNX+TxpYjKnSVYG9xurlm7w98mtAVaZyQSJ6YUd3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWU2utV9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so571985e9.0
        for <linux-efi@vger.kernel.org>; Wed, 22 Oct 2025 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761171941; x=1761776741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CHI40gqhI8Q2yg15Wy8NRvVOkttm7GsitlSpJmV8Bs=;
        b=SWU2utV9KEpycjGz9LiGRLm8QMrK+XyU4o8FViJUD38r+0zrZA3r8LGhti1VP63YQn
         k/cv92x/bfsekrmpeyDhhqrMnaH9tWft8fre7s4XiwqZSBfpRwInqK3ncrLSiSgrUeJ4
         FkyJJQFIeuNKEEw86w/Qr8VbsIOpCFqSS4V5DWrTIFTVmxUGdKEpbpVKXXFYZt9HP5Hu
         UcA0m/8qZ4e4eEev9hwF/4+yZHM7hBNl6uVSKV9eE/3/lkT3uREXl15F7MotHusoSDuE
         EdxvP7SS3BjY3HNrHgYz0GmSidosgX/sZ9izMVOqXmRRdBsWV+Bqe/vYccK8U0FIA2rz
         NDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761171941; x=1761776741;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CHI40gqhI8Q2yg15Wy8NRvVOkttm7GsitlSpJmV8Bs=;
        b=WRZRmy5gf8FQTIb6GSAG6a7dXbIS4s8qQaQUkBwuYKHSbao8ozpbUG9zDyJOO/poMl
         x0hUO4piU/v36K/+T8lUD7JBMzQJEhSb5tTBCStvl8Li1j+fEPeSDeFyOqMD+7OWM6wJ
         1HJDc1E54eRSUDBu6HKwLhHIaoTiavLF782u7ldnNcVfHoGEHhEYU8yWjVRKckJHGbxP
         Jkh2WZp41m1p8iBXuqM2Z1H5rszKSFncBtBJU9sd/F7rbnlqI/po6jKPEJ228UWXK5da
         vPC0zk+viBAPKJ3UTeKtVFFOxrbdcpFY9M4VjG4pM82L8pvAh6GfaMb6kLV+k1GfA9GL
         dN7g==
X-Forwarded-Encrypted: i=1; AJvYcCXzgijfSajK9F+23LcdPZ+nL6zjJjAVKaqOGjXtdc1z8DjkyGGOhPEokBMMzeNxIwle/gEtsLmIf2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzblDyISbAx3ijP53iy2x0ptz6piIPtWErsvi8GQOp4Kj+/Eo9a
	linJnDUiCt/h4PC6JIy8avzu6TP8xV12B6/bneAdgpQHtzVyj3GaBQXo
X-Gm-Gg: ASbGncv+W0/6r1UPssFJR8qpm4XtQ+ycKH8THc6gqMSM/Bzy59HAxD/gsZ7OikvWPxe
	TPv59TyxEr6wyWE5kchByq8wBUMBHhcpagtKc1LZPHcdxdMBxdRBGLSVmI4b1I08VQlgHrW2TDg
	5kYrwdvalXJNRJgK3Lq0T+RwrAap9QErqS+9ZLftzJqkwZgmPNWv8gLnYFPrP+MAqOvszs8IzFt
	qRJaChyOzznTHjVmMe8LRhDkRwfZ9Z3MMhAaDqbnSDExNvPMgncJHck3pyQaxeHLt6PjpDajCfy
	oCqU+9LxPB0OXWcHUckZwjyQfvsEx+Q9A9KTGdQ9J+ZT25QRhQhX4exvqabfDn+I2kNboGgRVYW
	Hlvr/bllbcRm+u7g/q4lQonbOg7GdSbOCvP286W9lwoPG4hCNnLDbn8AzyRJqWpjCQmHNY5cb8Y
	Gmkz2cF0aSmxzfuh1iSKbkLk0JZfhYy/+Y4d9ozsLqDmhat7OFj3lZiC780eQEX+MelccR536ZW
	NIYJ6bGWA==
X-Google-Smtp-Source: AGHT+IGTNA4/b7FqW0eVsBJIdErpxHmtmplTz/ZCxBbR4cMjaiNHiw9gx4Rcw7HPveUQghO9QxU9ig==
X-Received: by 2002:a05:600c:310e:b0:46e:4925:c74f with SMTP id 5b1f17b1804b1-4711790bf16mr144032225e9.20.1761171941305;
        Wed, 22 Oct 2025 15:25:41 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5? ([2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf2eb9csm3367335e9.14.2025.10.22.15.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 15:25:40 -0700 (PDT)
Message-ID: <b202b140-b669-4260-891d-aa451521664a@gmail.com>
Date: Wed, 22 Oct 2025 23:25:39 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] x86: Fix kexec 5-level to 4-level paging transition
Content-Language: en-GB
To: dwmw@amazon.co.uk, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, ardb@kernel.org, hpa@zytor.com
Cc: x86@kernel.org, apopple@nvidia.com, thuth@redhat.com,
 nik.borisov@suse.com, kas@kernel.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, kernel-team@meta.com,
 Michael van der Westhuizen <rmikey@meta.com>, Tobias Fleig <tfleig@meta.com>
References: <20251022220755.1026144-1-usamaarif642@gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20251022220755.1026144-1-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/10/2025 23:06, Usama Arif wrote:
> This series addresses critical bugs in the kexec path when transitioning
> from a kernel using 5-level page tables to one using 4-level page tables.
> 
> The root cause is improper handling of PGD entry value during the page level
> transition. Specifically p4d value is masked with PAGE_MASK instead of
> PTE_PFN_MASK, failing to account for high-order software bits like
> _PAGE_BIT_NOPTISHADOW (bit 58).

s/p4d value/PGD entry value/ for consistency.

