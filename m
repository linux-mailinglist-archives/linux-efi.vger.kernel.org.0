Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A892C9292
	for <lists+linux-efi@lfdr.de>; Wed,  2 Oct 2019 21:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfJBToN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Oct 2019 15:44:13 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:9150 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727257AbfJBToN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Oct 2019 15:44:13 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92JemoQ029831;
        Wed, 2 Oct 2019 15:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=XSeNTl5I855C3uT83to227D7zveqjCiQR4dEW0mojwU=;
 b=mAA0DqTfmnbi2N7jy1TpGlhS6QTuPqyrRPRBjPuijgRCAh6oaMhwmzKgZWOshHlOREEZ
 lAv1DCkrqIb1+zWLXOGfKkr+Akxxotuwci6BYTbQokHwCdNMF/1veRPxOlueKXB+HjCL
 LE9CAomPyuh9yk+xUTKlkphXB+0dQFVhTG8muMP5cWQ7MEcZrCGHF3r242AZ+1wFaaz3
 wLeMz9zc2fjoqGz0Mg0l6YO65NByMHXgeqCnQcS4RDfj6NYA6Sl66nQymi1w01I7i9Sy
 VYehOhx0EvITenA9Zi0XUKiJq3jdkHL1JJQUBumGnPWrYfTG/BQaMXASQ4p8TaEhCYZT rw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2va2uk4p8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Oct 2019 15:44:11 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92JhBMc084375;
        Wed, 2 Oct 2019 15:44:10 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0a-00154901.pphosted.com with ESMTP id 2va25gew0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 15:44:10 -0400
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="382563207"
From:   <Narendra.K@dell.com>
To:     <linux-efi@vger.kernel.org>
CC:     <Mario.Limonciello@dell.com>, <ard.biesheuvel@linaro.org>,
        <geert@linux-m68k.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
        <mingo@kernel.org>, <Narendra.K@dell.com>
Subject: [PATCH] Ask user input only when CONFIG_X86 or CONFIG_COMPILE_TEST is
 set to y
Thread-Topic: [PATCH] Ask user input only when CONFIG_X86 or
 CONFIG_COMPILE_TEST is set to y
Thread-Index: AQHVeVm8hd3/NfhPNEW1ErxPMn2a1Q==
Date:   Wed, 2 Oct 2019 19:44:00 +0000
Message-ID: <20191002194346.GA3792@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73613574CD0BB740BB500DF328D5F721@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-02_08:2019-10-01,2019-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910020154
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910020153
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Narendra K <Narendra.K@dell.com>

For the EFI_RCI2_TABLE kconfig option, 'make oldconfig' asks the user
for input as it is a new kconfig option in kernel version 5.4. This patch
modifies the kconfig option to ask the user for input only when CONFIG_X86
or CONFIG_COMPILE_TEST is set to y.

The patch also makes EFI_RCI2_TABLE kconfig option depend on CONFIG_EFI.

Signed-off-by: Narendra K <Narendra.K@dell.com>
---
The patch is created on kernel version 5.4-rc1.

Hi Ard, I have made following changes -

- changed the prompt string from "EFI Runtime Configuration
Interface Table Version 2 Support" to "EFI RCI Table Version 2 Support"
as the string crossed 80 char limit.=20

- added "depends on EFI" so that code builds only when CONFIG_EFI is
set to y.

- added 'default n' for ease of understanding though default is set to n.

 drivers/firmware/efi/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 178ee8106828..6e4c46e8a954 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -181,7 +181,10 @@ config RESET_ATTACK_MITIGATION
 	  reboots.
=20
 config EFI_RCI2_TABLE
-	bool "EFI Runtime Configuration Interface Table Version 2 Support"
+	bool
+	prompt "EFI RCI Table Version 2 Support" if X86 || COMPILE_TEST
+	depends on EFI
+	default n
 	help
 	  Displays the content of the Runtime Configuration Interface
 	  Table version 2 on Dell EMC PowerEdge systems as a binary
--=20
2.18.1

--=20
With regards,
Narendra K=
