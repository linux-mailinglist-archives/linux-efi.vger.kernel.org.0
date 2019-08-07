Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2360784C7C
	for <lists+linux-efi@lfdr.de>; Wed,  7 Aug 2019 15:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbfHGNJk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Aug 2019 09:09:40 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:5588 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387976AbfHGNJk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Aug 2019 09:09:40 -0400
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77D4qja011561
        for <linux-efi@vger.kernel.org>; Wed, 7 Aug 2019 09:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=smtpout1;
 bh=BXwIKGs65JOqHWK37gq8nP3JA3fGp5nQJW1/ba63F0U=;
 b=MCTjqrTy9RuRrltcWp4PxuGdYr3xmEsnTZxlGF7xO/J9jUQ3nvI2eViQLZBigXURS9wW
 vuls33bJ3JsNXTjpLCssPqMsKXXEiROjtYyPZVsTE6h0YdbZq9XgWz1zqrTJQihOFm8H
 PCxR1IQ0fg4wnJWmqiNk0vNI6Pp4TKsWEcUAgQAvIcNk8JNola8qBSe2BGyjlet9Q49T
 S7Qmrq/Ne1d5XV8g/33YApTEh+WXrNrpDbP1xHBNLBtLnPHMK0RI6x6LRRqrXKQXbu/y
 rohrA2zbcN2OvUi7hH7xtyqx8scWpGhm/XO/e3qDFyzim+otOJvlZ97faxjfYC2O8v8j fw== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2u7etnksa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Wed, 07 Aug 2019 09:09:39 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77D4dMC015794
        for <linux-efi@vger.kernel.org>; Wed, 7 Aug 2019 09:09:38 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2u7uxrb2p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-efi@vger.kernel.org>; Wed, 07 Aug 2019 09:09:38 -0400
X-LoopCount0: from 10.166.134.87
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="357883817"
From:   <Narendra.K@dell.com>
To:     <Mario.Limonciello@dell.com>
CC:     <Narendra.K@dell.com>, <linux-efi@vger.kernel.org>,
        <ard.biesheuvel@linaro.org>, <pjones@redhat.com>,
        <Stuart.Hayes@dell.com>
Subject: Re: [PATCH v1] Export Runtime Configuration Interface table to sysfs
Thread-Topic: [PATCH v1] Export Runtime Configuration Interface table to sysfs
Thread-Index: AQHVN1GRuuFZ1FIGT0iRonG1BybW8KbGCe0ggCltsgA=
Date:   Wed, 7 Aug 2019 13:09:00 +0000
Message-ID: <20190807130840.GA2147@localhost.localdomain>
References: <20190710185853.GA2645@localhost.localdomain>
 <3b26bccb3caa4360a552f1dc57b9ac24@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <3b26bccb3caa4360a552f1dc57b9ac24@AUSX13MPC105.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <232F402DA266A343A67E4D27449AFEE2@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070142
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908070143
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jul 11, 2019 at 11:00:37PM +0000, Limonciello, Mario wrote:
> > -----Original Message-----
> > From: K, Narendra
> > Sent: Wednesday, July 10, 2019 11:59 AM
> > To: linux-efi@vger.kernel.org; ard.biesheuvel@linaro.org; pjones@redhat=
.com
> > Cc: K, Narendra; Hayes, Stuart; Limonciello, Mario
> > Subject: [PATCH v1] Export Runtime Configuration Interface table to sys=
fs
> >=20
> > From: Narendra K <Narendra.K@dell.com>
> >=20
> > System firmware advertises the address of the 'Runtime Configuration In=
terface
> > table version 2 (RCI2)' via an EFI Configuration Table entry. This code=
 retrieves
> > the RCI2 table from the address and exports it to sysfs as a binary att=
ribute 'rci2'
> > under /sys/firmware/efi/tables directory.
> > The approach adopted is similar to the attribute 'DMI' under
> > /sys/firmware/dmi/tables.
> >=20
> > RCI2 table contains BIOS HII in XML format and is used to populate BIOS=
 setup
> > page in Dell EMC OpenManage Server Administrator tool.
> > The BIOS setup page contains BIOS tokens which can be configured.
> >=20
> > Signed-off-by: Narendra K <Narendra.K@dell.com>
>=20
> Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>

Hi Ard,

Does the version 1 of the patch look good ? Please share your thoughts.

>=20
> > ---
> > Hi Ard, the review comment in the v0 version of the patch suggested tha=
t the
> > kconfig symbol be set to Y for X86. I made a change to the suggestion.
> > In the v1 version, I have set the symbol to N by default and added a no=
te to the
> > help section to make it Y for Dell EMC PowerEdge systems. If it needs t=
o be
> > changed, I will resubmit the patch after changing it to implement the s=
uggestion.
> >=20
> > The patch is created on 'next' branch of efi tree.
> >=20
> > v0 -> v1:
> > - Introduced a new Kconfig symbol CONFIG_EFI_RCI2_TABLE and compile
> > RCI2 table support if it is set. Set the symbol to N by default.
> > - Removed calling 'efi_rci2_sysfs_init' from drivers/firmware/efi/efi.c=
 and made
> > it a 'late_initcall' in drivers/firmware/efi/rci2_table.c.
> > Removed the function declaration from include/linux/efi.h.
> >=20
> > RFC -> v0:
> > - Removed rci2 table from struct efi and defined it in rci2_table.c sim=
ilar to the
> > way uv_systab_phys is defined in arch/x86/platform/uv/bios_uv.c
> > - Removed the oem_tables array and added rci2 to common_tables array
> > - Removed the string 'rci2' from the common_tables array so that it is =
not
> > printed in dmesg.
> > - Merged function 'efi_rci2_table_init' into 'efi_rci2_sysfs_init' func=
tion to avoid
> > calling early_memremap/unmap functions.

--=20
With regards,
Narendra K=
