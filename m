Return-Path: <linux-efi+bounces-4238-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12878AFE5A1
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 12:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9B3486EA4
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B3C28CF52;
	Wed,  9 Jul 2025 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Vc9IcAPY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eYUpMbwb"
X-Original-To: linux-efi@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EBC28B7DE;
	Wed,  9 Jul 2025 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056625; cv=none; b=iQNQbFQ3HAmR6ZwlCrjcaJkiHMzE9DPdGJdLUVYpHZuJK/p+NJ13zPnw05aaj1zRQGfJspf7aB6PbLAT3Gd3SyHpcLxHB51Bt6QIn4SSsqiei38MRirjsfkPX3c5OPCl1KuE1tYGf4IL0OdWqtABnOdKbd1m/Wj36lSWDYEHWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056625; c=relaxed/simple;
	bh=ULf6rUBrZVO5AevxDkStFm71r8YXmSZHbUlldzfLwK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGHGNGoIxwtRNZJMlPz22jPEg5pbR8mw2fotzYxuimtL5okF2Yc4BzfQ3dQ3kkDq7BZwcWdDa8VMjz+gycLud5whL+xP740bgy9NkrkHDM3clapVwiU3NfziRHV2voZHxedXzFj80DnpVhZvKkxkw1NcXfhevCBDD2WmaT/J2Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Vc9IcAPY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eYUpMbwb; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 556F67A021B;
	Wed,  9 Jul 2025 06:23:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 09 Jul 2025 06:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1752056622; x=
	1752143022; bh=Wu+n0Ja3TQbYudPFKLGaBfu0YfVoEzLVb+bh9sJM1DQ=; b=V
	c9IcAPYhfJbBn1AbnlDLgUc5JkPZSWTX8mcFdAfoR6X7UDdRNZg8zugqYElJ8f/f
	7W9c9Y38O5GoSZunE+37/VGGAZnczAfUz/X6pDow702lC6GGiYAeEbNecjna2kOp
	AI+duTQdajap88RJhKBy5iVBUS0JaFAkSljHSotFmNUXHuNSp+POtfT8WZktleXG
	zCG2WXLsi9UJgrAa0S3riy+Vund+iCsj3CsQ4QwCEVrPupgfwWACrxA5d1JdElf/
	cIjo4Ed5kOdZpWNopYMh5UfvufCJzVRaaH7Ups1LIf3l39XfSbHzAZKuq8Kxw7HU
	gLEfPNHnaiWx09Irj8u3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752056622; x=1752143022; bh=Wu+n0Ja3TQbYudPFKLGaBfu0YfVoEzLVb+b
	h9sJM1DQ=; b=eYUpMbwbJOQpyLvBhjMHbSKaIbT7MvGp+CdCuj50CsZLT+ZRVMD
	6ZpPzWUcvswShYHBLt3n9aNEHKvfBQxbMHgRpWRJgVwX5jTWGTGJg1i3lOg7BRHA
	XoTgj9p7DrKe9ltX0bm82HV//uK0k5atQtefnR1lANa3rSiFj89+WoTtoaTD/QYc
	ONkuMAjZuRqoHnIgkAnYDFC6RPeVk0s1p2TXMeJeZBIYa60cuNmR9oP2MnnOnvxE
	aFm40AP2AJj59S9pa6SU7WszsVTD2WQ9ElfKv3pN/MTOb0wZGifFDTEuG9NGnSJr
	kQKoC2xfSIEBtbZr62utNnrmjgDBfkQDfoQ==
X-ME-Sender: <xms:LUNuaNX6jNreFIv8fm7AvAnp46upsrcv-55ZildBMgQqrj-HAaHDAQ>
    <xme:LUNuaDHBSPDG3eJSalkpC7v-N1qJ57lgUTxB8dGZZVLhwAvTY_F0UdwsribbWj55C
    drxjFh3f31iZ1vH6ko>
X-ME-Received: <xmr:LUNuaIcZt24nrtpmnW9j2lVsCkZ50sKB8El4-RSzxoFFOBfKS6ORsFLANQINPNWzoxEk6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpedfmfhirhhilhhl
    ucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
    eqnecuggftrfgrthhtvghrnhepffdvveeuteduhffhffevlefhteefveevkeelveejuddu
    vedvuddvleetudevhfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphht
    thhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghruggsodhgihhtse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgvfhhisehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsphesrghlihgvnh
    ekrdguvgdprhgtphhtthhopehmihhnghhosehkvghrnhgvlhdrohhrghdprhgtphhtthho
    peguihhonhhnrghglhgriigvsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkvghvih
    hnlhhouhhghhhlihhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:LUNuaEo28ghIH8_Qn9hO0ppJz_8rU4ipKyH8TBPGvryHJQ5aF0WuWQ>
    <xmx:LUNuaBAYivZpTMpyRZokx9hDOtKNXTjfriYUVUrqy7tIEHYcy_xfrA>
    <xmx:LUNuaFfAGpZY2slYfPnyzYFoqlTp0jU0sgkfc3Z5DNkE5MHeST4sCg>
    <xmx:LUNuaJuu0xm0KhiYQWMfkeMUzAbMh7H6I_ntVhz2LV1xp92ujtYHGw>
    <xmx:LkNuaDM_-taFVi_39zSxGkB3RHxnWXGASCFm6Es2efu28tAVUeVOvm9n>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 06:23:37 -0400 (EDT)
Date: Wed, 9 Jul 2025 13:23:33 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 00/24] x86: strict separation of startup code
Message-ID: <og5rlraf4zar6s3pvtcxpsvqomcrkzt3gxeojwnfljvpweobn5@6ee3wmdl6egn>
References: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>

On Wed, Jul 09, 2025 at 10:08:41AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> !!! Boot tested on non-SEV guest ONLY !!!!

TDX guest boots fine.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

