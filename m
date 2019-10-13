Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D981FD5778
	for <lists+linux-efi@lfdr.de>; Sun, 13 Oct 2019 20:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfJMS5M (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 13 Oct 2019 14:57:12 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:53762 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728786AbfJMS5M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 13 Oct 2019 14:57:12 -0400
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9D9hblI000581;
        Sun, 13 Oct 2019 14:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=5/QVgGKjIHBI0qEyVpdJ7Um4CsG8ZXjt3A4AM5XuhKo=;
 b=jd1oLeG6j83hNGhxZlqgt3I5fit4g5QWbnzp+kyZhkBpt+mxrySRED13mXlcCwufYPDO
 Sy7Ixcdo0MLvtikSxngdgDPfMO6qFg8dHZYuaNL63yXbe4AOF//J6DEXzGnmWcDa5ZQk
 NQNtk4FhjkiCQZ0xdICOU2sEIb/Zc4NIs1/jHbi2UsAwbztvrdXtmJh6HOPyAG0DARFM
 jwp7ov2tyg1E8M2gD5nrwU0u5wk9Nj9AgfxqYGzjwHv23cOEmvMuFQXkbhPFCD5KOwJ2
 +j2ShY9edGw5y3nGA8Zr7phSZgEJSBMqfovi/DUF6jRi0eQUR/VytC0hJqeE5gsVkK47 mw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2vkauf4g3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Oct 2019 14:57:11 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9DIrFPN138914;
        Sun, 13 Oct 2019 14:57:10 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0a-00154901.pphosted.com with ESMTP id 2vm5k7hx7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Oct 2019 14:57:10 -0400
X-LoopCount0: from 10.166.132.195
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="869461726"
From:   <Narendra.K@dell.com>
To:     <linux-efi@vger.kernel.org>
CC:     <ard.biesheuvel@linaro.org>, <Mario.Limonciello@dell.com>,
        <geert@linux-m68k.org>, <mingo@kernel.org>, <tglx@linutronix.de>,
        <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
        <Narendra.K@dell.com>
Subject: [PATCH v1] Ask user input only when CONFIG_X86 or CONFIG_COMPILE_TEST
 is set to y
Thread-Topic: [PATCH v1] Ask user input only when CONFIG_X86 or
 CONFIG_COMPILE_TEST is set to y
Thread-Index: AQHVgfgBvGXu4mhWM0KINjBW7iNITA==
Date:   Sun, 13 Oct 2019 18:57:05 +0000
Message-ID: <20191013185643.GA2583@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <78906FD792F54249A61BFC9D5047C4D7@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-13_09:2019-10-10,2019-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910130189
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910120072
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Narendra K <Narendra.K@dell.com>

For the EFI_RCI2_TABLE kconfig option, 'make oldconfig' asks the user
for input on platforms where the option may not be applicable. This patch
modifies the kconfig option to ask the user for input only when CONFIG_X86
or CONFIG_COMPILE_TEST is set to y.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fix-suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Narendra K <Narendra.K@dell.com>
---
 drivers/firmware/efi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 178ee8106828..b248870a9806 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -182,6 +182,7 @@ config RESET_ATTACK_MITIGATION
=20
 config EFI_RCI2_TABLE
 	bool "EFI Runtime Configuration Interface Table Version 2 Support"
+	depends on X86 || COMPILE_TEST
 	help
 	  Displays the content of the Runtime Configuration Interface
 	  Table version 2 on Dell EMC PowerEdge systems as a binary
--=20
2.18.1

--=20
With regards,
Narendra K=
