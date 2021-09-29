Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9BF41BD82
	for <lists+linux-efi@lfdr.de>; Wed, 29 Sep 2021 05:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241485AbhI2Dhq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 23:37:46 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50582 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbhI2Dhp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Sep 2021 23:37:45 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 44A26806A8;
        Wed, 29 Sep 2021 16:36:03 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1632886563;
        bh=vadnfXHyGvbSD/b7LCNSZLQJrorqhBFEir8Vsgqwb/g=;
        h=From:To:Cc:Subject:Date;
        b=qJCMFj7Wwv/Ve23IqsQCtlKZG5+0eS1YEWEUwCqq6Uy1ZUKSyAddTUu1cM+1SowXF
         pgRN1DTzlVDSHYfkHEmnFS045L9EPqsec1S8/ghJ9A5gcF4fvAvt+kBGCB/1xpNzvG
         k6/oOAEjahQmK0lHld1BXQxKf7ex0+xvHNoeTMz7xMFwyEyyGGpiM6CPQhLzvoFBY2
         K+fiJDuvpZE3hzb/nBcMMqFJyJsxlXOFByp9OdSeHtB4JoONDKxisXbDFZCry2ccWO
         Qrbxk4/1NI+UVRnIZMl6mnxjXl1Ir6wWS23xjuqDXoQHtaXnOwLCGS4sO2s0kbuITj
         TN2GnHxsgsJJw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6153df230000>; Wed, 29 Sep 2021 16:36:03 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.26])
        by pat.atlnz.lc (Postfix) with ESMTP id 12D4713EE5E;
        Wed, 29 Sep 2021 16:36:03 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 1115E2A1B41; Wed, 29 Sep 2021 16:36:03 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     James.Bottomley@HansenPartnership.com
Cc:     linux-efi@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] doc: efi-readvar: Fix typo in command examples
Date:   Wed, 29 Sep 2021 16:35:54 +1300
Message-Id: <20210929033554.1038566-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=AIwNeVlb c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=7QKq2e-ADPsA:10 a=4rT8kBe7LgzBiqWBg0wA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The tool name is efi-readvar not efi-readvars. Update the examples in
the man page.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Hi James,

I couldn't see an obvious mailing list for efitools so hopefully sending =
it
direct to you with linux-efi on the Cc list will get this where it needs =
to go.

Thanks,
Chris

 doc/efi-readvar.1.in | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/efi-readvar.1.in b/doc/efi-readvar.1.in
index ae41042..e3a5cc8 100644
--- a/doc/efi-readvar.1.in
+++ b/doc/efi-readvar.1.in
@@ -14,12 +14,12 @@ represents the first entry of signature list zero.
=20
 To see all the variables, type
=20
-efi-readvars
+efi-readvar
=20
 To see the second entry of signature list 1 for the db variable, do
=20
-efi-readvars -v db -s 1-1
+efi-readvar -v db -s 1-1
=20
 To see all entries of signature list 0 for the KEK
=20
-efi-readvars -v KEK -s 0
+efi-readvar -v KEK -s 0
--=20
2.33.0

