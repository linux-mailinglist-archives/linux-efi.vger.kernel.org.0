Return-Path: <linux-efi+bounces-2749-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA40BA299FD
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 20:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D353A6A7F
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 19:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C251FC0E9;
	Wed,  5 Feb 2025 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mkQp6EC+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46AF1FF1DE
	for <linux-efi@vger.kernel.org>; Wed,  5 Feb 2025 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738783058; cv=none; b=N18f4FoELTUqU0ZeNAhNx2ViSpZifN1Kt5E3HcZFPDqn5jbC7UqAtqAcdMwSbhbTvGJEAaYjbbapDnFq7hqZRPTx772G30hP6VH1/gXjMKQ9S/z6a4VIGyja5IcMmT+dwV7Nf/zUwnIElpDtNNM1e8MerpQ/gfUvLHC3kSDPe7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738783058; c=relaxed/simple;
	bh=XLYpLYH+lbFcCgkKm8AppmEwarNkV6tLVU4HUATQ84A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T14Mddr6+N6Jfo+kJhG9JIkiZK+/R4+pjjaYm46bpIOuN4tpOXwbFBj4cwaZAx06EZzT7yx+yU5EYKbibXjy+i6dBooii1cqiCEaQTz4FfiDlKek7Vagt+iqorKd10ZrKtU4UoBpXGla+pJTiavuRMKEUUPUUaHTk6qV/nOsXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mkQp6EC+; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6eeff1fdfso4995885a.2
        for <linux-efi@vger.kernel.org>; Wed, 05 Feb 2025 11:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738783055; x=1739387855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q6hZ5i4uGM77E91i+vVgQnF7/jN3WqwvtuuTzpTp8gk=;
        b=mkQp6EC+MBn16sjKBaDVue3xzKtM8pdMcl8/1Xd9qR+R3+mmnWv2XQZbp2TpmUlQfk
         ioDo7kQm9eNMmDpDyF+jpVLb3jRgYxDgyJpvU1Y991nXQJCB163k+kb4VsFluMbAZsSI
         fAJICTk/eqd68lC82SxZmtVTr1Dbz6V8+iynjkQtHksgiIfwJW9shQieaMbjiqncBh7g
         Otpzfp4Z5QFKbehC7LHlmszvjXL1kKp2iW4VhArXQtKsH2bJ/WhMZR8KFekWxvyURT1/
         ebnckl8kXdwtwbwH1lxV/t1qMfqh2ibASD/dVD7fegROmpbOrt63lukP7jS5/oVbrpfz
         shmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738783055; x=1739387855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6hZ5i4uGM77E91i+vVgQnF7/jN3WqwvtuuTzpTp8gk=;
        b=l04RqRN/Vo8fDOJA4IE1VNKacmKLkrW+ck/uLwYCZyoG6v0oCZe8UEs2VGGfz2sFHz
         /DgjwQ/o4V7vwdm01cMI5p1XQugVRF0cwiUzCs/HdR/Mp6Eqs2zx0kb4VXTerkKpvop1
         hPHequ/S1ocUsnO9TZ1lvMvits86kvyaJbHcRR+xDOY4E10Jy+2Epi1N9laPyUsQP+wS
         kLfOYQugL9IsgXjiItumgLj1ZcraT7aKAuCimNAydR7DyCCjqc9Tte8KzI6ASviOiFmC
         JnmACTV2BhHwvhwRizh1h/5/ElKF5X+7P8d5sB+3ay3H48+6/ukw43zZiLn2Ik5YgxIo
         kTvA==
X-Gm-Message-State: AOJu0YxgnjdM/MpFfeDUcHp8qgT8Vz9LdvuWA5LPOZyt6OhzdliPpdbZ
	nPZMM3HXOr6jm5M6SP6tBCTvn1heTb6shF0adrF7h8L6nK/89Cxo6wKxxwhBEPM=
X-Gm-Gg: ASbGncvRDO7RKLjXuChOK5ON/+ZA44e183iOYd9+sBGipxJfiaueuElzmq2C6svw9kQ
	wDmxMbIMInONF+CDfuOrHAaoTlHwayOViLpIvFDbS74p+TX17UUkHL6iIhjsWkOdL4lhqITR1Cd
	UKhVNiFt1i5pZZPqyoHL8Eb+sHmhcmbeCELivMwO/SjYUqOq5FLjw+nfYz49GfG4Ip04CMAgLtV
	TF/HNt1QxCljHVHLetRtUSSy+sQhEGPSbiNvw2OvZ6/d5uRB4uHC+gf4T/glXGbcUIdSVuPtk1g
	I8Y/ZxYoH0RKg60RhVVp2I1SAteinaA6UzlWkx9SxS8Gn9u0S31ZPZmkG5nuebula2F7ufH8lg=
	=
X-Google-Smtp-Source: AGHT+IFZQarDTzB54Kw6beyPzV5fjHD8DeB0Ab1xvPcLzHDuFGzQUMrAaJDjENdFi/8n2EjfAvGJ5Q==
X-Received: by 2002:a05:620a:4089:b0:7b1:1180:a455 with SMTP id af79cd13be357-7c039f9974bmr572670685a.22.1738783055498;
        Wed, 05 Feb 2025 11:17:35 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8d0573sm781697585a.37.2025.02.05.11.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:17:35 -0800 (PST)
Date: Wed, 5 Feb 2025 14:17:33 -0500
From: Gregory Price <gourry@gourry.net>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v6 1/6] efi/cper, cxl: Prefix protocol error struct and
 function names with cxl_
Message-ID: <Z6O5Tbf3l8A8_uEt@gourry-fedora-PF4VCD3F>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-2-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-2-Smita.KoralahalliChannabasappa@amd.com>

On Thu, Jan 23, 2025 at 08:44:16AM +0000, Smita Koralahalli wrote:
> Rename the protocol error struct from struct cper_sec_prot_err to
> struct cxl_cper_sec_prot_err and cper_print_prot_err() to
> cxl_cper_print_prot_err() to maintain naming consistency. No
> functional changes.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

