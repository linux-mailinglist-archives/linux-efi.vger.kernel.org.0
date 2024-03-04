Return-Path: <linux-efi+bounces-685-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449E686FC72
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 09:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F323528153E
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4EB20B02;
	Mon,  4 Mar 2024 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crafticoz.com header.i=@crafticoz.com header.b="ZJulpHTe"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.crafticoz.com (mail.crafticoz.com [217.61.16.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D3D1BC47
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.61.16.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542265; cv=none; b=SUViDdBIbolgNRXIdkoDYOUfVjrmNje2aW/iCJDC1o+FoWzwleh+yDpTLYevU4LEROftfBCT/TXQbHWC5zi2Ne0MZyLryCeA0+Ca5RDtWqV/lp0EbQlv5ensdv/eV2othUVM13btFllaaVVsiwsfksssCtKQxNy1BiWeWwEd4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542265; c=relaxed/simple;
	bh=1IoqoUjByUuGlvKIsPqzKB660hvTAuw0hON+G/wNfyM=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=mYsF8vKjBERVv5wsBUGrRRwB+R/cVz3kWAM39aEClCfUfQNtZx5PloAP4zlbLK5Opgr6Jpu1j3GCfPlWcUaFBn5TVVnJkfMmSrVYXWb6Fhal2n7NzCii5coMappxwCHak7j0zGwbEHUJ2yT9wmwbqaWKaY/sfttovrYWLuHWET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crafticoz.com; spf=pass smtp.mailfrom=crafticoz.com; dkim=pass (2048-bit key) header.d=crafticoz.com header.i=@crafticoz.com header.b=ZJulpHTe; arc=none smtp.client-ip=217.61.16.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crafticoz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crafticoz.com
Received: by mail.crafticoz.com (Postfix, from userid 1002)
	id 26E2282597; Mon,  4 Mar 2024 09:50:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crafticoz.com;
	s=mail; t=1709542260;
	bh=1IoqoUjByUuGlvKIsPqzKB660hvTAuw0hON+G/wNfyM=;
	h=Date:From:To:Subject:From;
	b=ZJulpHTe6u5bHvJ/dIcd6lHX5GDAZpCIqF6bpKotVZePjcJbytt5WCWfvdQTy/keW
	 R0uVOxNRwOgJX1fgQjvDBNiOdgQzVnWd2wbxHDk7Mc2Qmh+fCaMs1f2re/KHjAwpzI
	 aO5O/U9rnkoDtNeaGDN+rJcdlL4Gx0VVWBL0UUm90PCX7nW9fVjTKOUzfGDOVMOHYh
	 Vq7VTY700jwdAjJH88OdcaQSUhHztMQ4PZkTMFPmijlLzFJ2hkGVoZz2ChQwEbWQ0C
	 lzRJzr1M0Usk8JLrbVAgzJaRx13fx7iXBUhb3YdN1SqZ/Mq/+hwxxQQk+MYLQfQVT8
	 wS8DHRWE89cOg==
Received: by mail.crafticoz.com for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 08:50:59 GMT
Message-ID: <20240304084500-0.1.18.3j4q.0.s0fm336odw@crafticoz.com>
Date: Mon,  4 Mar 2024 08:50:59 GMT
From: "Maxwell Atlee" <maxwell.atlee@crafticoz.com>
To: <linux-efi@vger.kernel.org>
Subject: Development of new flavors
X-Mailer: mail.crafticoz.com
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Are you interested in expanding your offer with innovative food products?

We offer freeze-dried fruits and vegetables in various fractions and orga=
nic and conventional versions. We mix and pack our products, delivering r=
eady-made mixtures for direct use in production.

They can be added to various food products, from breakfast cereals to ice=
 cream, which gives a wide scope for experimenting and introducing new fl=
avors and a completely new range. We provide support in developing the co=
ncept and turning it into a real product.

I will be happy to provide you with details and provide samples for you t=
o test. We can talk?


Best regards
Maxwell Atlee

