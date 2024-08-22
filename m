Return-Path: <linux-efi+bounces-1569-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E1295B346
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 12:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F0D2836F2
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 10:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86569183CA5;
	Thu, 22 Aug 2024 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b="lhSM6N0F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qlQXi0Og"
X-Original-To: linux-efi@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5CC166F3D;
	Thu, 22 Aug 2024 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324192; cv=none; b=FzAVI7PtDIEfxA/L1x0zI2ANJdKMnqNFE1pNzbTXAGVKEeDJXCpMHRjTxY/uej9VVJ94yesPn8EYnkpciQqhqu9Et7YxNf/9EYXE3woupfPQpQVHvou/fX3iQyx7J5YAXujXPMeXr7W03u8cbFm/fY1n7E70I0CNPeN1A+zVAbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324192; c=relaxed/simple;
	bh=9VAzPXP0yAx0cd+vsCr1BnDmKh5mz33Zt2lS7Q04KSg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HUFNFqZW+TeKG+Vjs/WKPoo8mXZfV1HFRXs1xEoPzjXkEKYGTVAQLQyP0z47yt+NKXquuylDCz1ifeujruG30kBsX8XX1MJS6HV6Vy0BkgQV+RXFk1AC82pIOVuIVmWSyqfnXv9hkcDXOs8BknM9N2VYZcobJxgjKpxHog5yFyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc; spf=pass smtp.mailfrom=jfarr.cc; dkim=pass (2048-bit key) header.d=jfarr.cc header.i=@jfarr.cc header.b=lhSM6N0F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qlQXi0Og; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jfarr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jfarr.cc
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5BA10138FC54;
	Thu, 22 Aug 2024 06:56:29 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 22 Aug 2024 06:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724324189;
	 x=1724410589; bh=ZLaLyJEH9kAfKRmJ7C9mQmjk14xh4u+FXopaAqi2VN8=; b=
	lhSM6N0FPks4+A+qc5VwYCIhb49FxO/NT/Y5fYZwykIZO1L32xZ0fqRg5ovXGgb6
	ok9gRWUxKXrUqHKDusthrherCwa344O6Fnd/x5rCa8VxyrF+AwzHcGoGitCwL23K
	lVB8Lx+XCuPS+P7wmguWt0aIcXilkYiNccs7PsghfhuDdHyE0zOYUgBB+sQbgxDd
	RlReFhIsXDQRcxkSJhZFsRJC4xR6r20baZygaSkv42mfkav1tBcyqN4a//3rsxtn
	loGW0vJrQ/8uTKCzjU9uwA9QB9+jn1FwO5CwJ9BtMapsqviYytM1gT1IK1u2Ip14
	vYocBQfHjkFOZOQCz8Pmxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724324189; x=
	1724410589; bh=ZLaLyJEH9kAfKRmJ7C9mQmjk14xh4u+FXopaAqi2VN8=; b=q
	lQXi0OgCaiuSf5foI+YXfLATsug7LcWWj0ucMGwIhCGz10gmC6juSdNY22qLUdhH
	ddGBwYAoJrinrvFV/uUfPajTVtkQAQ+QVxu397m0/pmfNiHmc2fFftbu0xEfLWhs
	VdPwB9OSuXNMFEY0XFoyJygQqfJX13a+M6gg0xpQfTbujw5PRPhRDrfWAs9pMXOh
	cjA1Cy449T7j2MbHldTaIfnHAAU/iD5BN3FbUJOM9ai8FzcERltatx0Oh4heIu+p
	na3dQPg3iVZeWWId/jZFSw6ti3i4dDM2QrxYM+j4LE63Vge5p9aDZO6rrP0lwmxN
	j7tHYf1WOkZ8hrYkuB7pA==
X-ME-Sender: <xms:XBnHZsPXLAFwdU3KNEtUuScoXi0ht7Ug7A0_6XEV5c2pP81eoWuPMw>
    <xme:XBnHZi8sqxM_-UkAzwWZ7Ce2M5Sb1mOksGUCTna1U2DAuGNh44rw-qs9Ul_29iDPx
    PRdVKGmbLpbLUZ612A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdluddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthejredtredttdenucfhrhhomhepfdflrghnucfjvghnughrihhkucfhrg
    hrrhdfuceokhgvrhhnvghlsehjfhgrrhhrrdgttgeqnecuggftrfgrthhtvghrnhepvdeu
    gfegheefudeikeeihfekgeevvedvkeduudejhedujeefgedvleffteeiffffnecuffhomh
    grihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvghlsehjfhgrrhhrrd
    gttgdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmiiigrhgvrghrhiestdhpohhinhhtvghrrdguvgdprhgtphhtthhopegtrghtrghlih
    hnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgr
    nhgusegrrhhmrdgtohhmpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjrghrkhhkoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvgigvggtsehlihhsthhsrdhinhhfrh
    gruggvrggurdhorhhgpdhrtghpthhtohepsghhvgesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepugihohhunhhgsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:XBnHZjRiSJ5uhVIWfntvv_tdKfRRzIx1KmTP1PqKDZlk6xphx3SuuQ>
    <xmx:XBnHZkv031FSjHiPTHeY2evQdxQ7GQqawYlO0HSlldcs6FaE30rhpQ>
    <xmx:XBnHZkcqPo1EYr-qJso-71jeYZWsIeGHIY7FDqUnEE-mfJi_7AwMew>
    <xmx:XBnHZo1mzgmqluJlONDy8nw0Az1p0BshL3g2BQ0yVyO83UiK5kNR0w>
    <xmx:XRnHZj_C7_bGGBPLtlDFN0agSRPIeKJNqTXmbTP2BuwpgG2xYtfC0dZp>
Feedback-ID: i01d149f8:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C7C90780062; Thu, 22 Aug 2024 06:56:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Aug 2024 12:56:07 +0200
From: "Jan Hendrik Farr" <kernel@jfarr.cc>
To: "Dave Young" <dyoung@redhat.com>, "Pingfan Liu" <piliu@redhat.com>
Cc: "Lennart Poettering" <mzxreary@0pointer.de>,
 "Ard Biesheuvel" <ardb@kernel.org>, "Philipp Rudo" <prudo@redhat.com>,
 "Jarkko Sakkinen" <jarkko@kernel.org>,
 "Eric Biederman" <ebiederm@xmission.com>, "Baoquan He" <bhe@redhat.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <ec8befa0-f193-4de3-acea-8e37f8437c7e@app.fastmail.com>
In-Reply-To: 
 <CALu+AoQRdxJUpNK_eCjKJ=ydRZ4av2S3xBaz3CYJZp12xqm=jQ@mail.gmail.com>
References: <20240819145417.23367-1-piliu@redhat.com>
 <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
 <CALu+AoQRdxJUpNK_eCjKJ=ydRZ4av2S3xBaz3CYJZp12xqm=jQ@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Dave,

> I forgot why we can not just extract the kernel from UKI and then load
> it directly,  if the embedded kernel is also signed it should be good?

The problem is that in the basic usecase for UKI you only sign the entire
UKI PE file and not the included kernel, because you only want that kernel
to be run with that one initrd and that one kernel cmdline.

So at a minimum you have to have the signature on the whole UKI checked by
the kernel and than have the kernel extract UKI into its parts unless you
somehow want to extent trust into userspace to have a helper program do that.

That's what my UKI support implementation from last year did.

v1: https://lore.kernel.org/lkml/20230909161851.223627-1-kernel@jfarr.cc/
v2: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfarr.cc/
v3-wip: https://github.com/Cydox/linux/blob/2908db6d8556fa617298cfb713355edaa9e4b095/arch/x86/kernel/kexec-uki.c

It however also lacks support for the "side-car" files. One option to add them
would be to load them using subsequent calls to kexec_file_load with a special
flag maybe.

TPM measurements are also not done although they are way easier to
implement with this approach as we still have the rest of the kernel around.

However TPM measurements in this case would be implemented by the kexec loader
in the kernel not by the UKI deciding what to measure. So we would have to
have a very firm agreement on what to measure.

Going the UEFI emulator route gives the UKI format (and other (future) formats)
way more flexibility. The cost is to potentially implementing a large portion
of the UEFI spec, especially if the goal is to support future unknown formats
which IIRC was one of the reasons this approach was suggested.

Kind regards,
Jan

