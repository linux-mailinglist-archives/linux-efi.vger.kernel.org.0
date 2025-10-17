Return-Path: <linux-efi+bounces-5067-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0329CBE8B94
	for <lists+linux-efi@lfdr.de>; Fri, 17 Oct 2025 15:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC8D1AA4B98
	for <lists+linux-efi@lfdr.de>; Fri, 17 Oct 2025 13:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B273331A64;
	Fri, 17 Oct 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b="jSMXxffa"
X-Original-To: linux-efi@vger.kernel.org
Received: from manage.vyzra.com (unknown [104.128.60.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78270331A57
	for <linux-efi@vger.kernel.org>; Fri, 17 Oct 2025 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.128.60.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706308; cv=none; b=fFhXtEUD61SZ8OSOOz2zMeYLw+Q94o/MeeiswuBXlC5pEOGD1FKe3ehHz9XzvZD/JPeDn2Z8AoG40cfkOkiLsxsIQg1Imc5eA+jxVmc0e3IkGoEFTTyCLa9iOilJ/nGTTHZ9E9zFZ0jZqKz4lwOJVlgPcNNtPheX2qBsijDpKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706308; c=relaxed/simple;
	bh=biLnUx9jTTyVdIbdiavoTAgEZeIqqOihfb373MH/e18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YiC+HhiKn8PBSLypbFVUE/xH0UXesDXblH7wj+huFS3QDcJp5PSklvGCtnBODudeQjy5xjOx6dVgHXbBF93oWec/zXZ95qABG6L+yCTU++fEvSvF6d7l6pMjtGjYl1eZBjX1MKs29QkTvSxY5nbfjAbO3S3vt4NOsvPy1eE0T10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org; spf=none smtp.mailfrom=manage.vyzra.com; dkim=fail (0-bit key) header.d=debtmanager.org header.i=@debtmanager.org header.b=jSMXxffa reason="key not found in DNS"; arc=none smtp.client-ip=104.128.60.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debtmanager.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=manage.vyzra.com
Received: from debtmanager.org (unknown [103.237.86.103])
	by manage.vyzra.com (Postfix) with ESMTPA id 7872A42E0AD5
	for <linux-efi@vger.kernel.org>; Fri, 17 Oct 2025 07:45:32 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debtmanager.org;
	s=DKIM2021; t=1760705133; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Aj8bDacQlJB5qNMC5+yWWged1+K/M8YReXQkzUminbQ=;
	b=jSMXxffaf+odmch2UuAAhq2pbyTBWgQfJ9dzJc1WPv49WfhzHfyTS+VS0DsD16jvslE8CF
	zZCqBkr+wcdLFdKCCZTpHb4KvoaGEO+705AoRvuawXjZSlnNUMfq/LmO04RRYNsFAABH5X
	FKnz/Wif0s25PiXVJgyYLnds7kQx83w9wzbcxUKwBiTIo8CmUw2aFHzwGaDbj6sDgDsoFI
	t1nvd0WSPn2HUXUw+WYs55Ed9s8Fn0RmVH68Ee2BeQgOK97ymF6KgWgU3i1n6FpF2PIqu3
	s3cUliRrPw5Nh7ZJs3r/PkCIrgrD7MvvxJfOu0i17bGC70a7/8klivzSUCDyyw==
Reply-To: vlad.dinu@rdslink.ro
From: "Vlad Dinu" <info@debtmanager.org>
To: linux-efi@vger.kernel.org
Subject: *** Urgent Change ***
Date: 17 Oct 2025 05:45:31 -0700
Message-ID: <20251017054531.7DA4EA75BD398C61@debtmanager.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -0.10

Hello,

I am Vlad Dinu, the newly appointed Director of IMF Legal=20
Affairs, Security and Investigation. I have been given the=20
responsibility to look into all the payments that are still=20
pending and owed to fund beneficiaries / scam victims worldwide.

This action was taken because there have been issues with some=20
banks not being able to send or release money to the correct=20
beneficiary accounts. We have found out that some directors in=20
different organizations are moving pending funds to their own=20
chosen accounts instead of where they should go.

During my investigation, I discovered that an account was=20
reported to redirect your funds to a bank in Sweden.
The details of that account are provided below. I would like you=20
to confirm if you are aware of this new information, as we are=20
now planning to send the payment to the account mentioned.

NAME OF BENEFICIARY: ERIK KASPERSSON
BANK NAME: SWEDBANK AB
ADDRESS: REPSLAGAREGATAN 23A, 582 22 LINK=C3=96PING, SWEDEN
SWIFT CODE: SWEDSESS
ACCOUNT NUMBER: 84806-31282205


A payment instruction has been issued by the Department of=20
Treasury for an immediate release of your payment to the bank=20
account above without further prejudice. We cannot approve or=20
schedule payment to the 

given bank account without your confirmation. May we proceed with=20
the transfer to the Beneficiary: Erik Kaspersson, bank account in=20
Sweden?

I await your urgent response.

Mr. Vlad Dinu.

