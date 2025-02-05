Return-Path: <linux-efi+bounces-2752-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFDFA29A5B
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 20:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1886D167AF4
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 19:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A258DF5C;
	Wed,  5 Feb 2025 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="q9k7rDL9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A741E0DE4
	for <linux-efi@vger.kernel.org>; Wed,  5 Feb 2025 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785029; cv=none; b=PRiROWs7i0+8Ol60GNafhLn5Mz5odiHLAJh9QeiHoHk4r4r5FLZ4MaTKER9eHxBY0arWjUSVnPwwPcl3EEghbu63QSS3kkr/PsvLC7bRR5qNbIat5ozUHVnCNpQGElA5h8/R9BfYJI0CqdKQGoVQpbO5QYimdhJtJVy0mjo4Dkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785029; c=relaxed/simple;
	bh=n8j3DGOLUHU7uRmc+FhLpi4ngVKHsDZJ/NqvWTWKGcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvGUZu1am8ShlBZbOU407qz9VPIPGwZRhPNzIaO0cnXJQ98gy+wULm5MqwYK7pzxCPVnAztXlZ7Rv8kjhvVEb+SOe1cnojltH37iy/YNdpfbjISdzSr9z+ZvnNVutX5GYOAA0U8izta2MidbmdZF2mDyFZ0hIGJQ6N879sxN5C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=q9k7rDL9; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6f53c12adso8522385a.1
        for <linux-efi@vger.kernel.org>; Wed, 05 Feb 2025 11:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738785025; x=1739389825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JB1QhklLlkYCU54lqW0Pm1NXVvCDDXyC2idxgwvRo9A=;
        b=q9k7rDL9USHXqJYagynqTeWaqNWXooVFaKv4xC8LkdZmIJ/DQHRzFAwuNo6xNgepDb
         Uj3oef18e/jHX/CQfS9WStux1RPBpIxiXz6FeDDIp/5zDrLIqk+BCRUuH89lXkfsyja7
         4fk1twEZBpwHepIzwizC89qadIImAsx1ddtPY9AolaDtPy4EPp2w5W/ZpeTc5RkarUH4
         mwGf5XGH4QAswMR4uLHfo4ffc70w4UXSN1JFgUfmjbwlLeRxXPnI14DaryOXKwpdZ19B
         04oo++rpYP11iN/6HnJ4exH0FThIKopmy6SomPBMtPuFmel1x94fho3NOrYXShmXnVRJ
         6HFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738785025; x=1739389825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB1QhklLlkYCU54lqW0Pm1NXVvCDDXyC2idxgwvRo9A=;
        b=u2sgkOkLwWKwzj8G6mmwIecTwwJuvnwWhrt43YFdufRW1UeCJomABKmAuAlD1Rz7/2
         m9ZK6Qk/2ZYoI/ofo3C1GdRwWnFToVTTkxE9sdPEd1pwg7ylFpGDPYtYzVBH8ac/L5R3
         RPjYOxjb2wxj3/+dmJyNCH1XunacJfOfR7NbFguhGK7giDQ/kEqOD5hfTWRD99ZrYFhR
         d4cHh0RxZ9MxLu0m4JoEc0TpS/nHkn5dsDBs4Gh/Mf+xWpCU8rkh1QVDkCiQGZ/BFG6e
         4osbvwBJV/uxWnb7aDcDLalgj0uBbexLsaHItuQeT1NHzbycTHtN0vAL8+TMwaYpZxFr
         EcDA==
X-Gm-Message-State: AOJu0YxxhVvWL28K1XS4ao+0p+HIfilnaNoDHVhFdS1A9OlulZAnIg/q
	z7Zrph6yf6hCR4PtiyUDD9XOsWH82AOH0ZHAhLGGfOW7mqbG6a4/QlQ+3J2FIo8=
X-Gm-Gg: ASbGnctWQLjvlZe8VAMlGynY8rmktxcgdFgDnyNB4AhGDAJQ8l1PtaVvU3mR4vI7aBa
	NFEvb/pCpyC9U263uQBUKkh8AvrGF7fW3L8Uns8FYVyyegfBrfJ3qr1r+L+KAAqMGgiJaC27z19
	gp2E0CZzT7c8oUxbfJJ9XHD/2SF51SgsPyewvI+Ek3lfHiuOAIA5WXSyWbLChcuyRWTSP6AenBo
	CtYDSWTInLxsqNq/JuBIZJ5igbK4ctKiKsfI9AGwr4JY60SqnLtmdbSjYhz8MwCTWWVMjkjltuO
	8PwofNepzZmd0G7S3T7M910E2BvT6qCIxu9SR1I4UzZSHN+uGRsM1b75lCZe7VS+VkdBM91H8A=
	=
X-Google-Smtp-Source: AGHT+IGcFSjOMu8RpqfHkHlk/VsaPfJwj2d6oLcZx7tPWUMVQrzAwbXbG3wdktaK5qXTF1GIr6IVqA==
X-Received: by 2002:a05:6214:21ed:b0:6d8:af37:ae5b with SMTP id 6a1803df08f44-6e42fc83442mr59146136d6.43.1738785025216;
        Wed, 05 Feb 2025 11:50:25 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e42169524csm23923566d6.125.2025.02.05.11.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:50:24 -0800 (PST)
Date: Wed, 5 Feb 2025 14:50:22 -0500
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
Subject: Re: [PATCH v6 5/6] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
Message-ID: <Z6PA_hN-3ZtWbhUh@gourry-fedora-PF4VCD3F>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-6-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-6-Smita.KoralahalliChannabasappa@amd.com>

On Thu, Jan 23, 2025 at 08:44:20AM +0000, Smita Koralahalli wrote:
> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
> CPER records. Introduce support for handling and logging CXL Protocol
> errors.
> 
> The defined trace events cxl_aer_uncorrectable_error and
> cxl_aer_correctable_error trace native CXL AER endpoint errors. Reuse them
> to trace FW-First Protocol errors.
> 
> Since the CXL code is required to be called from process context and
> GHES is in interrupt context, use workqueues for processing.
> 
> Similar to CXL CPER event handling, use kfifo to handle errors as it
> simplifies queue processing by providing lock free fifo operations.
> 
> Add the ability for the CXL sub-system to register a workqueue to
> process CXL CPER protocol errors.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

