Return-Path: <linux-efi+bounces-1571-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA9195B41E
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 13:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A007E1C22BC7
	for <lists+linux-efi@lfdr.de>; Thu, 22 Aug 2024 11:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6244D17E011;
	Thu, 22 Aug 2024 11:45:46 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE1317BB38;
	Thu, 22 Aug 2024 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327146; cv=none; b=IDcc9T188cuRVCQXSN9v3HJECEW/Ir2GjknFX8PNISTGjkh/hoijum5fv1xbGQ9BvgVpWCZR/v8UaHfEhN6NhnThawnbwi/4ftAtZfyPTLKHEt9+1SXbPQyOWhGPk4O50EkN7B8OfHBBg5YDSYCvvAlx29QeB+3H3wSmKJ1N5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327146; c=relaxed/simple;
	bh=31ogjTvX3LLwhdgTiQO8ce3e4SZCePnT8wIyPwJdsqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/J5EIaiNB3RSlPwVhQtctZ8uKeuaPM+Bejrw1roYTp/FIl5UTtHsLG4F3iAFqeVBgGTpTluH+p9Qx8GyxGoNO+1GO1U5sMV8mGfQWxDW+1r8uYG2OG9ormMHrQcqvgPUVucz0sBgGidYWvjgxqsaSBctX67aMPj2QZtwcb6rZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id 422E9E80263;
	Thu, 22 Aug 2024 13:45:40 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 9E79516008A; Thu, 22 Aug 2024 13:45:38 +0200 (CEST)
Date: Thu, 22 Aug 2024 13:45:37 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Pingfan Liu <piliu@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	Philipp Rudo <prudo@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <Zsck4U9xmzz5w5tl@gardel-login>
References: <20240819145417.23367-1-piliu@redhat.com>
 <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
 <Zsb1isJ2cYRp2jpj@gardel-login>
 <CAF+s44TauSXk-gDgRHn=6CsQrAv8Q-QyGXkDJO+_sTh_yKde5w@mail.gmail.com>
 <gnym722ge3bgzz765u7plh65kq2tk7odw7hs4nq5ufxdp5xauf@bgb32wlzcchc>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gnym722ge3bgzz765u7plh65kq2tk7odw7hs4nq5ufxdp5xauf@bgb32wlzcchc>

On Do, 22.08.24 13:42, Jan Hendrik Farr (kernel@jfarr.cc) wrote:

> I have two questions:
>
> 1: Does the systemd-stub only perform measurements before exiting boot
> services or also afterwards?

Nope. we pass control to the kernel's own stub, and that calls EBS(),
not systemd-stub. Hence, no, we are just measuring a things before
EBS(), not after.

Lennart

--
Lennart Poettering, Berlin

