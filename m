Return-Path: <linux-efi+bounces-2766-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC1AA2AEE9
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 18:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863A23A5F85
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC1A166F06;
	Thu,  6 Feb 2025 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HbtTq2HJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4923958D
	for <linux-efi@vger.kernel.org>; Thu,  6 Feb 2025 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863140; cv=none; b=JL2nAPo+7qopJ2V5BEI6S+jriu6/9eWyHt76qvZwkSxwdPfakWK0St25u7OZrsiVcp+cJ1t/O0wOxgbsMu2HBeSnWW0toOk8u4g44uKOxdZTPRpmj4RMQPq/+es5hDijH3tddj7FT1kb6NzzloA+c4EKhZnwwYk7qIM5bL3IEjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863140; c=relaxed/simple;
	bh=qXL4u5HtBh7zMGEdVRYSIwU4cTJd5ZFAEgvCBEfFL4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MU2wSJpLPzOW/QpPg8cxcRvpBJSq+ckK/FD5JXrs8ZxAA0nVPBbV3Oh/m+nJppXlV7DDSwIIJOkafZX/yZDYpl6kuIkydij01GrBTJAOwlXMtznmghh2c47EZXLboPzJnVEbXo/e8RwHI5SC5Sx3SNGUOr0k9IFyfybIq/UFWgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HbtTq2HJ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d8e8445219so9064746d6.0
        for <linux-efi@vger.kernel.org>; Thu, 06 Feb 2025 09:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738863138; x=1739467938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdXR13Nx3/oP+ZXCK66mPCS4i0K090PQPzNpGMGIMKk=;
        b=HbtTq2HJnz8V8lPUqCjTbbkxzetcVylU6mZtZ0XDNr/3uUXPv4q+V9LmPPHlTwPSLR
         1g1NcJftDolMVRPxoJ/B4gHQxdOgvnIbW2+5EGUl/e0RntWkjCmgAj5WmbuujZEW9UAV
         ywPJ087jZCNglTiDHKDU0LoVQp1ivrlzhpUB8s0ceaicD4j56Q/6lD5j3V8Xb1sC7KDF
         KaWKQx73vO1F1f1S6cOCdKG7xrCGtuMxzcKthPBoT7sp273hMe2VSakSVODYvwpyAAvb
         aMVOUQxPWotsD+YiLyetUbts5nc+eSAvtNwpnSWwyNbMS38UYYviyh6odY3b4KY3dBnI
         aYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738863138; x=1739467938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdXR13Nx3/oP+ZXCK66mPCS4i0K090PQPzNpGMGIMKk=;
        b=TawFQz8n1ZkISHc1ivGkttoQn+iuChfGFPgMu0cPy8lpzWv6w4YoeGQUCzu2O8SJKm
         AcXKps+yKQ2K/7LuOA4tqUex0GfKK/a/Y2whjvmeOnyrsEnl1ar7Ax4wqrStDfPhnwPP
         /nold7Z0YFGLXV+K2Clp62Mk6WiK9VPlYjo45nojg13/GC6PgIiXOVEeO2AhtIXo+3rk
         nZ22YZq5ZiyovlxNxEAeLUibxxob2W6LJ4XQluqV+F/xmvwf7CLRXrFSjamwLHB5p4FG
         dkeTHuCvAfXcCe+2PPDQ1I9QK/yBz0EVrnvmig2avxtQ+AIA5bcODZSceTdbWL2D67jW
         EMbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzXyB2zbHwDJYcOSR9RJnxh+32x/IBw3R2JY6YJ/+WHTcSZgFh27hkrT6A1+KiRNsbtiUu9kceuds=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywel/nwuoN5szB1qbz9h2aFvO4WSmUZzbY2WrqZlpi9D3Ok6Zxy
	ipSLMQbwdWjmj3+IBdoCZSxF3Zue3wpl1pkuQxuaFUg6TNW3WOhtkLbKwNREnqc=
X-Gm-Gg: ASbGncseht5C2mG1hDVmJRRdaw35P7AgR/HBb2bDovb4x4UnVmXog+Bm1oy5vBOt0rL
	jiZ2m2yOOD1rNbuTskS6uzbZ7b0i0weDTHfnCDCcwkdPBtKAcRaqW1sP9qLiH6seZrCJrOs7E5e
	Y8lVmRAqhf+sPe79dESA5ycnCoQCcL6K7QJtLEc/PLjB17mFrW4vIEpIBZpENPMEDmPQGFUB23u
	hBvgcuWUDVOFFZAZ0OvWfB/5TkYZU4JOcyjfRkh15gI5J94rCBD3KaCPUgrsnt5D7YFoczUWYsU
	wcJg3q04Di+cc32w5WCCCB05GK2gGKBVPQ4IBbvHfWZfp3W3WhfJRrHgY4DkLYacDJ33clezYg=
	=
X-Google-Smtp-Source: AGHT+IH+rTWcE0XmrlwB22b0oxWBjkrRHByjuXKCpywQFJ2469+IJXhpsIXyAxZX6kYsM3joAVpyQw==
X-Received: by 2002:a05:6214:5d85:b0:6d8:a148:9ac9 with SMTP id 6a1803df08f44-6e42fc53a18mr80698996d6.30.1738863137803;
        Thu, 06 Feb 2025 09:32:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43babbaf3sm7680136d6.109.2025.02.06.09.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:32:17 -0800 (PST)
Date: Thu, 6 Feb 2025 12:32:15 -0500
From: Gregory Price <gourry@gourry.net>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v6 2/6] efi/cper, cxl: Make definitions and structures
 global
Message-ID: <Z6TyHwbrxTcbhtzy@gourry-fedora-PF4VCD3F>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-3-Smita.KoralahalliChannabasappa@amd.com>
 <Z6O5JqL30lFr4S8Q@gourry-fedora-PF4VCD3F>
 <20250206105403.00007062@huawei.com>
 <Z6Tf0ZvZMfqth_t1@gourry-fedora-PF4VCD3F>
 <20250206-pretty-gabby-loon-d4e4c4@lemur>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206-pretty-gabby-loon-d4e4c4@lemur>

On Thu, Feb 06, 2025 at 12:14:03PM -0500, Konstantin Ryabitsev wrote:
> On Thu, Feb 06, 2025 at 11:14:09AM -0500, Gregory Price wrote:
> > trivia: The last upstream `Reveiwed` patch was 2017
> > 
> > Funny enough b4 takes the tag as-is.
> 
> Yeah, we can't possibly keep track of all the tags people use, with some
> projects getting creative with "Reviewed-and-edited-by:" or similar combined
> trailers. So, we just blanket accept any person-tags (that have a "Person Name
> <adddress@example.com>" format).
> 
> -K

Wasn't suggesting a change, I just found it kinda funny.

Should suggest tag-search on lwn.net to find all the fun typos.

~Gregory

