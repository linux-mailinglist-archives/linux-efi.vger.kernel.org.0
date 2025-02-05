Return-Path: <linux-efi+bounces-2748-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D29FA299F4
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 20:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045B51889CC8
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 19:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EFC1FF7CD;
	Wed,  5 Feb 2025 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="N4SOe/e9"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674241DBB03
	for <linux-efi@vger.kernel.org>; Wed,  5 Feb 2025 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738783021; cv=none; b=MV9YavvqKaBAVkWSTEWsl9YVNZEcka6w6tBPYgpsDPdAL2pX+A7KptfdCXC3u1Y/JZKoDt2UMpjQe+CXMeLnj0oIuNJjQwPtzqnfnUsltrePTPWSgTnf/H5j97r7O9Rx50nmiKiAbxGOjtcaHxjn2qB+iEnVxu2KzZN/T8eNliQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738783021; c=relaxed/simple;
	bh=mD7XWDvuIrkysisDXIVc/LntT2RD6K7r7e4lNQkKiXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4i2c0VAF0ZWq/yKQVyt1dLACFMGc2JVSPAxmcpuvgZeYr2+3BjK5hYeINlpHhWDIsnW7stS1vR+lfmDiAHSfznYxv6X26ASJvS5KKgXz+X1aCUq5UtbewA4jrErPTwi9JefpAeiSuOYgF3WpUz8MNgZwf6f1rLgqqBk9kg+nLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=N4SOe/e9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46fa734a0b8so1796131cf.1
        for <linux-efi@vger.kernel.org>; Wed, 05 Feb 2025 11:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738783017; x=1739387817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AyF22ck5wlRe12OagalfFv2Yzfm1UdTCcLrkvea++OY=;
        b=N4SOe/e9hKiJVKHbXzBtbVEFmpqqnzkAg7NMFRkHhES68d5jTKmOqZ6iSP+LWDx0K4
         PYRWpkGSLPu/gHfhfjll1jA+asQswBipplKHGq54G7+0En5dgpzpBTDSP0oJbvbpvKdF
         z6j7mtQnUmHlZ2LyHWeEjcn640fdXhgbX34N1xHV3Bz586nMVB3de63Y5mKhMnsLNoIa
         8OSGvovPXrjdhOlxn9gIpxcqMcNkbwERx0pkkP5ZVGeg4d4W7Qf97dycQndhFWlOIXow
         ZBxJjoDR52E8CHmvnpsP29D0Y+iG98IpNsZOzJ4/PvD/iOtO3tihCmJx5FEBTNkyoL7d
         E7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738783017; x=1739387817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyF22ck5wlRe12OagalfFv2Yzfm1UdTCcLrkvea++OY=;
        b=XuT8y0yftQEquanL4pBCM95HhyoHI+6+9PvpQkVZ1Zj1coTzg+Hs+pQa+yLZtzp37y
         JP1YA/xoUjy2LhWrkQKW0yDg0qoOMUcpUl3B6QiuvVZhgDBbRGhMvhifIOgLypfUDhCU
         PzoKpOnmOGv9sTXEJOuV4pOk9FTmGbbtxyNNWyRHFR05oFJIFfTNEtUpsduRKbPw68fl
         oij5g97YGBxPXAG02JIZqpPZ+p5R4Re9zdeZuwbLeGUsp21+7n6v+3p5066C30e3Vaw0
         G29Nx06zQYPpXUrR3ar2n3WSHfd66jOlmPvMnvN6tkYKjBAvBcdtU/uVziiQA7660YGd
         ksHQ==
X-Gm-Message-State: AOJu0Ywhkj22+RsqJ8X70Ony2tT9vC+OjiukoL/LVYTFgf3z4iRLG8SZ
	AW0mP8fkgJAWTWmrDXTQ1L/NCloHn+BQuYVb6pnel7+Whvcm6ZULe/X65ZiH8eA=
X-Gm-Gg: ASbGnct+sv9ku9g7n3bYoO64jX+d24fM+azVIX+PTf6uBbSeeTBSdFk8sA8Swmk1drN
	zP6sU5aqPKxIIy9DqXP6FxNA66c3bue2STuN6tOSpb2Z15lymnT3OeEobWZvl/fcxHOsxHk2Ye6
	JdboOsjMZ4eDPF0FD143S1sTfe4agBnKVbSO5TFVUtaIzc0laES4DJq0KzNRS5pmL0JVznrsFzM
	bwdcvBE+2j0lKDJHazxu/igkqzxgwt9FnOICNqqMZnJkrl6PtB0t+0/3TcQh90a3is2vRkd2joF
	8HqG4+QucPXFAtaEjKnH5Ochcz7EsZCk+0vHpNwkGEjmKxSUGo65ITwOsul8SZ70QqBBJb/gkA=
	=
X-Google-Smtp-Source: AGHT+IGT+yTwoj6CP/vGkbljNLoLAl7MggI/BIq25DtBgr/RTTH+LQZsYYwhHhuY7OgWFev0tmt1Nw==
X-Received: by 2002:a05:622a:1826:b0:46c:7651:158c with SMTP id d75a77b69052e-470282f1ee9mr41819711cf.48.1738783017294;
        Wed, 05 Feb 2025 11:16:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf189497sm73560951cf.73.2025.02.05.11.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:16:56 -0800 (PST)
Date: Wed, 5 Feb 2025 14:16:54 -0500
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
Subject: Re: [PATCH v6 2/6] efi/cper, cxl: Make definitions and structures
 global
Message-ID: <Z6O5JqL30lFr4S8Q@gourry-fedora-PF4VCD3F>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-3-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-3-Smita.KoralahalliChannabasappa@amd.com>

On Thu, Jan 23, 2025 at 08:44:17AM +0000, Smita Koralahalli wrote:
> In preparation to add tracepoint support, move protocol error UUID
> definition to a common location, Also, make struct CXL RAS capability,
> cxl_cper_sec_prot_err and CPER validation flags global for use across
> different modules.
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reveiwed-by: Gregory Price <gourry@gourry.net>


