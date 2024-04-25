Return-Path: <linux-efi+bounces-979-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D978B2325
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 15:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E7F1C21B06
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 13:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0E3149C7B;
	Thu, 25 Apr 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsQusExW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6EB149C58;
	Thu, 25 Apr 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053019; cv=none; b=qkmAYjegJDCKF+OwJiA2M+Cdf9T1fgSHb6rKqlsJbDXj6wCrmXE16lkp6bQDc+qKKYSkzqoyRyZ34Si1gcAAqssnTj05RIn5t5SRwhVeNmlJJgGF6aSbgXz3pjtFxQYcW427/W8aEuLPvXPnKbrni0K8uLYgyxHpWM72u4ZUowE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053019; c=relaxed/simple;
	bh=Ur1epNZf8SCZnUWyUB9wg/o/oFYnayGEc0XHX1GcfLQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XW9wWcD8FIitBWjfPptFZsd0nFJEa3YhLXr09eLvomrMBEfG9r2iyoCSViy/IxG/K8HN5Kro06hbPFEDJAlmfzpT93zYFoQNV8YzJF4+9rqjiafnIWZvpkbzUabh2OE2K/d5GrgUdeor4OVkbXhh+fn511uDTBAPll3nXkctD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsQusExW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1C6C113CC;
	Thu, 25 Apr 2024 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714053019;
	bh=Ur1epNZf8SCZnUWyUB9wg/o/oFYnayGEc0XHX1GcfLQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=hsQusExWR2QW6FUkSSQmS3xalGLAuYx1GjdG3KA+/XywcRX3H76mf16mWBb3JVzY8
	 Slatpr/xGEwnRfFlrPvFDACKSKsgV6b2gGb0eNFBKtt5ETtNW8zfR2qKNwVql1llVk
	 ZxVQLH1JKqT77/3QmXl020gwdwyvNPMZEkCAaRR6+RRwngzHANS9QF5Tyy94liaglN
	 iM+4kVVxou/MgA6JVSTPWT7e6SMzaPXO9hQm+r9jNhg8b8n0BYCGUFrdSAw8yn2g/k
	 q4h7+8UNlj4FqqxITYnHmQm2PpWkMgaB6SkXIaWDDRBG5AMAjH58ze7uXrsztnsL0A
	 q1Dyh/Vc7E8SA==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Apr 2024 16:50:14 +0300
Message-Id: <D0T930INM33C.1UVZR6MNZ4KV0@kernel.org>
Cc: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, <linux-efi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Lennart Poettering"
 <lennart@poettering.net>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mikko Rapeli" <mikko.rapeli@linaro.org>, "Ard Biesheuvel"
 <ardb@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240422112711.362779-1-mikko.rapeli@linaro.org>
 <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com>
 <ZiZhSfgeAdrbnaVL@nuoska>
 <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
 <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
 <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>
 <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com>
 <CAC_iWjLH=SDoTw_Pgr2hOKHkjEp_dKqwpUe9j6a=_WNW9UcxKw@mail.gmail.com>
 <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com>
 <ZioawGrx8gi3mqMg@nuoska>
In-Reply-To: <ZioawGrx8gi3mqMg@nuoska>

On Thu Apr 25, 2024 at 11:56 AM EEST, Mikko Rapeli wrote:
> 1) is there a TPM device

Translates to "Does /sys/class/tpm/tpm0 exists?"

TPM version can be determined with
/sys/class/tpm/tpm0/tpm_version_major

BR, Jarkko

