Return-Path: <linux-efi+bounces-804-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC868788B0
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 20:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F169D1C20D30
	for <lists+linux-efi@lfdr.de>; Mon, 11 Mar 2024 19:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ACC54F83;
	Mon, 11 Mar 2024 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSBnwAL4"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA3F54BFD;
	Mon, 11 Mar 2024 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184734; cv=none; b=S8z3DAjBj8PWGAP92/jdXlMTIo0xPuvCnpi/ussAJiKoHP22l7rgpBHCKbD79EHpBYi/FcT7+3WQ9+hQTqKlV1jC/cmu75irbExE9uuv1b23uQ5Vii12fknE82dWBVYv4drNAbw0KzZvbUFNBRYRGNY6SB2Q9TzuXZaKs6fm/Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184734; c=relaxed/simple;
	bh=SnsLiAArsJiUcaL+Q86TIl1DOdLyG2dXOzHJaHIJJZw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ohAY4YtPx0Ls05GJxpRmbwdJkRKoVyRKlzIKMUXJR6JW3JRful9R7b5PLBupPgvnly8oHxlcgd1ov2OqqsC1D2O0WH2h7N/uFLU/4on4XMgnWLNARDu4XC/gQqY7rwr7fBLrWjcVqSzx2sR3L2pHF38SYCBFn1dT3vECT6X46sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSBnwAL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB85CC433F1;
	Mon, 11 Mar 2024 19:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710184734;
	bh=SnsLiAArsJiUcaL+Q86TIl1DOdLyG2dXOzHJaHIJJZw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=TSBnwAL4qsjZc7nXzs4UFTw8PsGZkRPFp1bozKktd8pJeQgXLapV+0dzrDJXsTj3v
	 Es8iJsWaaT2EwwpYUMk2lJmSPLgpKh0eLPmmL3GPBmy8lv7arDf/zDiDVebSKWKe80
	 9n1Tel696kGfRAG7RbMPgCUahEzvu0vVthm4D1Kq7p7zYHKFKKwqf+BkTz/8t1zxwh
	 I8u2IhtonevqVo35afmH2ktBssohw6VuhJIB/049rn/ThIaWSQmmZDwZ2Dv+Vw2Kb9
	 uEZC/0sxpgmVZCyW5TkGKVYf0tjQ3zWQl5TJgemg+ZCWpUGPXITDpRipovcsLwSIs+
	 PZO8C4v34NQDw==
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Mar 2024 21:18:47 +0200
Message-Id: <CZR5W1VPAVJC.2VZOSD53YNT9I@kernel.org>
Cc: <dhowells@redhat.com>, <dwmw2@infradead.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <ardb@kernel.org>,
 <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
 <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
 <dmitry.kasatkin@gmail.com>, <mic@digikod.net>, <casey@schaufler-ca.com>,
 <stefanb@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <linux-efi@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH RFC 1/8] certs: Introduce ability to link to a system
 key
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Eric Snowberg" <eric.snowberg@oracle.com>,
 <linux-security-module@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240311161111.3268190-1-eric.snowberg@oracle.com>
 <20240311161111.3268190-2-eric.snowberg@oracle.com>
In-Reply-To: <20240311161111.3268190-2-eric.snowberg@oracle.com>

On Mon Mar 11, 2024 at 6:11 PM EET, Eric Snowberg wrote:
> +	return -1;

Missed this one: why a magic number?

BR, Jarkko

