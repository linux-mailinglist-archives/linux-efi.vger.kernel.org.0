Return-Path: <linux-efi+bounces-2902-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7662A55AD8
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 00:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA0B188FBB3
	for <lists+linux-efi@lfdr.de>; Thu,  6 Mar 2025 23:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B382036E3;
	Thu,  6 Mar 2025 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delugo.co.za header.i=@delugo.co.za header.b="aDA1nRnx"
X-Original-To: linux-efi@vger.kernel.org
Received: from outgoing1.cpt4.host-h.net (outgoing1.cpt4.host-h.net [197.189.247.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13A17B50B
	for <linux-efi@vger.kernel.org>; Thu,  6 Mar 2025 23:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=197.189.247.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303338; cv=none; b=L4lIeQY2KF3WAqkTNdEmkDRMe4m60e3srns/oOXn8njBYOf6ZS0eql5E/WjMn14tG01+cpgq3scI9JwyopBuAOYG8olJg5rGXIcBBXq2RPbsSuClFzSKjRp2BJolEolAxXqOBADWJtXkidIP1b1XXTRZOtBqGyukPjfgMh7ycz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303338; c=relaxed/simple;
	bh=UOdy1uc1Ja6Ouzx9Gp3orqw2OLpxN4Hd+lHG4CKFzvE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FwU4j1laDrAbAxo8OdDirVIPZhCPj2csXKH+PxAEPWd/H+UDp/CST6FjvvARjN9a/yR0cKhVQ0mXTT6ihdMCZklFKuDHG5wILpO6IBourT7Vu9XgsYnVOwr5xIBa+QOX1/FxkBaXGh0U3Nuspl/9bNoUIGyBRoz5FmtvgWKBHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delugo.co.za; spf=pass smtp.mailfrom=delugo.co.za; dkim=pass (2048-bit key) header.d=delugo.co.za header.i=@delugo.co.za header.b=aDA1nRnx; arc=none smtp.client-ip=197.189.247.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delugo.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delugo.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=delugo.co.za; s=xneelo; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:sender:cc:bcc:
	in-reply-to:references; bh=UOdy1uc1Ja6Ouzx9Gp3orqw2OLpxN4Hd+lHG4CKFzvE=; b=aD
	A1nRnxt+YcN4gu5pzkHchBmPkoRaJ3gjK7b7XAI+3LU5Vcai7qBIw/kQASVzthvPv+Vz1Mac4hEwu
	q1nRq0Vy+C9qhSVtx2lDF1NDr93PDsetyax/jne6yCaU9ePOMUMSZQ7AXw0CCX1EoL7jVbgdFM6Ey
	36mUrtexYetFCDQnNXOB7rnYd0WX2gfniFBJq7dq/oTrnOgSIM3cG0Byc/v6W0/s9VwXw7ZeV+5kV
	r7JLRCIpxd51++3OTUfJlI67C+VoDdcbgspjyhi1DwkfQERXOT3R/sXsN1mbu1LM0uXJ5xBH2QMWh
	7u5uNkgh+AVN5ExtHepBMah7vMxmyddQ==;
Received: from www46.cpt3.host-h.net ([197.221.14.46])
	by antispam1-cpt4.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <orders@delugo.co.za>)
	id 1tqKXb-001e5f-OD
	for linux-efi@vger.kernel.org; Fri, 07 Mar 2025 01:22:12 +0200
Received: from [104.192.5.240] (helo=delugo.co.za)
	by www46.cpt3.host-h.net with esmtpsa (TLS1.2:ECDHE_SECP521R1__RSA_SHA512__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <orders@delugo.co.za>)
	id 1tqK5d-0000000DmLH-1Zf1
	for linux-efi@vger.kernel.org;
	Fri, 07 Mar 2025 00:53:17 +0200
Reply-To: barry@investorstrustco.net
From: Barry <orders@delugo.co.za>
To: linux-efi@vger.kernel.org
Subject: Re: The Business Loan/financing.1
Date: 06 Mar 2025 22:53:16 +0000
Message-ID: <20250306223012.24A6D4F05D47DA69@delugo.co.za>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: orders@delugo.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: delugo.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@delugo.co.za
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.75)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT+5DhM0jw86KsbkaGfFMuQCPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5zW6GXhAL8MAO7sH/ZAkY4CU2Itm39BdCc4FEP6OrUewhPm
 p87GC1OZvsh7yKER8spgIIBy+ry+jilho6aMzblDeb4o0/MLsfRXq2B6Bj1eqDD4K7StLTuqEF9y
 eNim1jV+hJyAsgQN3+fJ25MXybLTUK8SYXIQrp7xzRip84U4OwRo87oeATC+hGtbNyLqD7/YM720
 mpXIX4fbAqVWiUEMYlwzjvDZ/FkpvR7cwSxN+RTHswbbB/ha+ZWrSAi8SkwqWAikMcSxTAWn8RCv
 ieGEzRrIdLp/AwmQcey+hPKVq9dnf3S1NcNv3U2dp/UbPvviEnzvvDcGs5qmm9XDE2pdJqvyYkhT
 hwsslykRZitI8icIFYnZsBkzvNJDT1vaZMrr4xH02iXtFm4w0sCOFbA4fwJOVDCkeSWm5+LqlnjK
 VXjpYNeJ770wY8Cv58UhX5OHiBSoGdSAwB7sMnqRmZNfcesLA3GlTLthqqp+mHWG0CxaRQsif/YU
 G8XfVQduyd16EipRzMVZ5LqwTx7Vvn9SVpfQCjlf31OWLN2NaNeFy2cMkdcBYI8cD/9SXtnMq7wb
 rhba46IXa0qNKt4H52rNKUYuguxnzQxeR+Wu8PsJhSt0b5LXsJGQVXKl8Un8zwEXlqtWoZXfDqNX
 VGm4yZ4d/OYnGZUQnca3k4Ez+h60/3A0mGHeGSZcpQEwQX1AA1EVHfNToDFlxTUwUA9PUHUQ2XKT
 4BCSi2w8mgvy3S772PmWw0RAW/rfuCe/I3sofOj6VQfb/c2NIfGrBGJmxhrCYfBTpIHLvTQd5zMm
 bnRvO8FvvUtaUwtwq1GZWRVxIYqyT1Pe05+1xxbrOC6X1v6aZtES8ui4t/zpAOMgqs4l1DfnqevI
 3eLXvW3yX2j47VIimOdNUtuGr9pN8oyUWrjyuTNa7IVsbMNf4F0zLZ5qoYrSJaSrU4KN07JTbdVq
 tu7HAV7fBAXEsn92rcwXFREi
X-Report-Abuse-To: spam@antispamquarantine.host-h.net
X-Complaints-To: abuse@antispammaster.host-h.net

Hello,

My name is Barry at Investment Consult, we are a consultancy and
brokerage Firm specializing in Growth Financial Loan and joint
partnership venture. We specialize in investments in all Private
and public sectors in a broad range of areas within our Financial
Investment Services.

 We are experts in financial and operational management, due
diligence and capital planning in all markets and industries. Our
Investors wish to invest in any viable Project presented by your
Management after reviews on your Business Project Presentation
Plan.

 We look forward to your Swift response. We also offer commission
to consultants and brokers for any partnership referrals.

 Regards,
Barry
Senior Broker

