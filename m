Return-Path: <linux-efi+bounces-2765-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1001A2AEA2
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 18:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013371888B0B
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2025 17:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73164239577;
	Thu,  6 Feb 2025 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nphDR97J"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F452239575;
	Thu,  6 Feb 2025 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738862048; cv=none; b=WC3mkW/zzsxaQYNtlB4aTZ4ndhPjDATmpPRFiNTeWgeg3zwM624LssslEPDN5f/FeptQBJ4RwPBG4YqGN/Ua9eIJQGoimBUjXMiJPF10kL6XEjtrIhv2cTRL7Krj2wFpmzb2oCWkzAnKR9K+kSqbxv8JCY9FCvRHzh+Nf+rC8T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738862048; c=relaxed/simple;
	bh=F7fky8VIi3/rjzXp72L0SvpBjKrRGeqgaeUkFCOxgPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W008xFtSOJMJZP1ePGPOhzfDbfZVKXkPaBS4FShuwGZ1OCHLIO1+N91MZ08YD7F90FI3VN1nV9R2nM1pN9vUrQKuSbVAbf8KOoIZx6S0MApz4dV08GMorOJCi7ONaWKTN8hFAUQlfbcbR8PWfvIHf6sBIInXcF0TZSP1bVO3fzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nphDR97J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F584C4CEDD;
	Thu,  6 Feb 2025 17:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738862047;
	bh=F7fky8VIi3/rjzXp72L0SvpBjKrRGeqgaeUkFCOxgPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nphDR97JMzyMJE7MHYF2zzTB0e7ByH3AHR0Smq2o4RsyO44KvMGIoO84djdiTvD2P
	 cv7CUXw5CLxlld1klFsTR5o0uV7/GVxCEKwCl5ZRUZ1dyTlZvL7eqe/YGouiwZZVAT
	 yyDk/o6k3w64fWFNsTYvaFAjq4ZDwSG/VJVaZ7Nw=
Date: Thu, 6 Feb 2025 12:14:03 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Gregory Price <gourry@gourry.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v6 2/6] efi/cper, cxl: Make definitions and structures
 global
Message-ID: <20250206-pretty-gabby-loon-d4e4c4@lemur>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-3-Smita.KoralahalliChannabasappa@amd.com>
 <Z6O5JqL30lFr4S8Q@gourry-fedora-PF4VCD3F>
 <20250206105403.00007062@huawei.com>
 <Z6Tf0ZvZMfqth_t1@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6Tf0ZvZMfqth_t1@gourry-fedora-PF4VCD3F>

On Thu, Feb 06, 2025 at 11:14:09AM -0500, Gregory Price wrote:
> > Reviewed...
> > 
> > If Dave picks this up will need to tweak that.
> > > 
> > 
> 
> that egg on your face when someone has to spellcheck your tags
> :facepalm:
> 
> trivia: The last upstream `Reveiwed` patch was 2017
> 
> Funny enough b4 takes the tag as-is.

Yeah, we can't possibly keep track of all the tags people use, with some
projects getting creative with "Reviewed-and-edited-by:" or similar combined
trailers. So, we just blanket accept any person-tags (that have a "Person Name
<adddress@example.com>" format).

-K

