Return-Path: <linux-efi+bounces-1583-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA3695F323
	for <lists+linux-efi@lfdr.de>; Mon, 26 Aug 2024 15:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02B0284C19
	for <lists+linux-efi@lfdr.de>; Mon, 26 Aug 2024 13:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B8B53362;
	Mon, 26 Aug 2024 13:40:12 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9ED139D;
	Mon, 26 Aug 2024 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724679612; cv=none; b=UEGPQWkI+5Pmfs4qfnwW8t9z/QVNfXshdImHAtx2ivTxPrmWIyr4DlYyiLwMe3gYLHj1ZMHwJxluLU4l/g883wo5SB1O6sOOeqp9DzVKNKvbqVwqmJtoJoUc+GBCOvUBHcMwrt7ZtHRQg4evH1VU1uXPOnr/Np8Kj82Nfl2sV0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724679612; c=relaxed/simple;
	bh=63wPTOZAi7ElVDFDDCVRJ1akW1q4DpgN3YC3i3lUfxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c32eBHvMhlt2wVUUjfAjNG6R4AXWor9TXnBhywVMDL1kT+466ahNR0Y01o+UDKfOx6NI9M122YtTSbbO5l+cWoz5IKMmDcjEJgsOekEYukgCfU2caAGfy+neY7VIifwiQt4s5PH8VKSWtbbkjh7/CswicKpAOtb3k8X7t83MrBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id B36E5E80262;
	Mon, 26 Aug 2024 15:39:59 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 3829116008B; Mon, 26 Aug 2024 15:39:59 +0200 (CEST)
Date: Mon, 26 Aug 2024 15:39:59 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <ZsyFr8V6yizMiBTw@gardel-login>
References: <20240819145417.23367-1-piliu@redhat.com>
 <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
 <Zsb1isJ2cYRp2jpj@gardel-login>
 <CAF+s44SQtRxZz=2eSJ-xP44ORLqvq0doEQ8qrw+1RaKFhoje8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF+s44SQtRxZz=2eSJ-xP44ORLqvq0doEQ8qrw+1RaKFhoje8w@mail.gmail.com>

On Do, 22.08.24 22:29, Pingfan Liu (piliu@redhat.com) wrote:

> > Hmm, I'd really think about this with some priority. The measurement
> > stuff should not be an afterthought, it typically has major
> > implications on how you design your transitions, because measurements
> > of some component always need to happen *before* you pass control to
> > it, otherwise they are pointless.
> >
>
> At present, my emulator returns false to is_efi_secure_boot(), so
> systemd-stub does not care about the measurement, and moves on.
>
> Could you enlighten me about how systemd utilizes the measurement? I
> grepped 'TPM2_PCR_KERNEL_CONFIG', and saw the systemd-stub asks to
> extend PCR. But where is the value checked? I guess the systemd will
> hang if the check fails.

systemd's "systemd-pcrlock" tool will look for measurements like that
and generate disk encryption TPM policies from that.

Lennart

--
Lennart Poettering, Berlin

