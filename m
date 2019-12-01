Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6151F10E2DD
	for <lists+linux-efi@lfdr.de>; Sun,  1 Dec 2019 19:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfLASPb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Dec 2019 13:15:31 -0500
Received: from mtax.cdmx.gob.mx ([187.141.35.197]:14798 "EHLO mtax.cdmx.gob.mx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbfLASPa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 1 Dec 2019 13:15:30 -0500
X-Greylist: delayed 6338 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Dec 2019 13:15:29 EST
X-NAI-Header: Modified by McAfee Email Gateway (4500)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cdmx.gob.mx; s=72359050-3965-11E6-920A-0192F7A2F08E;
        t=1575217567; h=DKIM-Filter:X-Virus-Scanned:
         Content-Type:MIME-Version:Content-Transfer-Encoding:
         Content-Description:Subject:To:From:Date:Message-Id:
         X-AnalysisOut:X-AnalysisOut:X-AnalysisOut:
         X-AnalysisOut:X-AnalysisOut:X-SAAS-TrackingID:
         X-NAI-Spam-Flag:X-NAI-Spam-Threshold:X-NAI-Spam-Score:
         X-NAI-Spam-Rules:X-NAI-Spam-Version; bh=M
        8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs4
        8=; b=DREyFgb+6YP8ZJ838ouaKR+SYHeyWov50zf9xnL2slO/
        5iD9eGh/FanefdrW9iEac78myvvs/RaOLLpeEd75eFkIE9Uh1b
        3IU3dG4VwKVhTXFF1L2Uy6vCNDnncKEJ9GaBqvVT+cOVxt1BOB
        oMLBDZENIx30VrlMPsUMOH5xHBU=
Received: from cdmx.gob.mx (correo.cdmx.gob.mx [10.250.108.150]) by mtax.cdmx.gob.mx with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 1dee_6015_6b9d1d6f_074f_4fcf_a67b_ca2709636e41;
        Sun, 01 Dec 2019 10:26:06 -0600
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id 8C8CC1E279E;
        Sun,  1 Dec 2019 10:18:01 -0600 (CST)
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id I0Ipsr4Y46fJ; Sun,  1 Dec 2019 10:18:01 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id DB6011E288C;
        Sun,  1 Dec 2019 10:12:53 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 cdmx.gob.mx DB6011E288C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdmx.gob.mx;
        s=72359050-3965-11E6-920A-0192F7A2F08E; t=1575216773;
        bh=M8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs48=;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:To:
         From:Date:Message-Id;
        b=UosItHi/PZW8CLWYOF4WOVEU+uIVSFssJ6x8AUd36w3gXR/1lpxAb3iONhsIa3XAv
         bUHMbRBc75zjr19GTGe7DpSHpkl7SFLPWOagP7MRlTagrFHspOUgrSPrQ0kv5Ek6jd
         NxTIqoHDe2G0VDnKFgaLav/yadah62w0J0gdaQCg=
X-Virus-Scanned: amavisd-new at cdmx.gob.mx
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HcgX-uQPjmSD; Sun,  1 Dec 2019 10:12:53 -0600 (CST)
Received: from [192.168.0.104] (unknown [188.125.168.160])
        by cdmx.gob.mx (Postfix) with ESMTPSA id 0273B1E29AE;
        Sun,  1 Dec 2019 10:04:04 -0600 (CST)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Congratulations
To:     Recipients <aac-styfe@cdmx.gob.mx>
From:   "Bishop Johnr" <aac-styfe@cdmx.gob.mx>
Date:   Sun, 01 Dec 2019 17:03:57 +0100
Message-Id: <20191201160405.0273B1E29AE@cdmx.gob.mx>
X-AnalysisOut: [v=2.2 cv=HeFkdmM8 c=1 sm=1 tr=0 p=6K-Ig8iNAUou4E5wYCEA:9 p]
X-AnalysisOut: [=zRI05YRXt28A:10 a=T6zFoIZ12MK39YzkfxrL7A==:117 a=9152RP8M]
X-AnalysisOut: [6GQqDhC/mI/QXQ==:17 a=8nJEP1OIZ-IA:10 a=pxVhFHJ0LMsA:10 a=]
X-AnalysisOut: [pGLkceISAAAA:8 a=wPNLvfGTeEIA:10 a=M8O0W8wq6qAA:10 a=Ygvjr]
X-AnalysisOut: [iKHvHXA2FhpO6d-:22]
X-SAAS-TrackingID: d99e3ed5.0.23901106.00-2391.40382938.s12p02m002.mxlogic.net
X-NAI-Spam-Flag: NO
X-NAI-Spam-Threshold: 3
X-NAI-Spam-Score: -5000
X-NAI-Spam-Rules: 1 Rules triggered
        WHITELISTED=-5000
X-NAI-Spam-Version: 2.3.0.9418 : core <6686> : inlines <7165> : streams
 <1840193> : uri <2949749>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Money was donated to you by Mr and Mrs Allen and Violet Large, just contact=
 them with this email for more information =


EMail: allenandvioletlargeaward@gmail.com
