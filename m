Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D1986946
	for <lists+linux-efi@lfdr.de>; Thu,  8 Aug 2019 21:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403901AbfHHTDN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Aug 2019 15:03:13 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:43762 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390280AbfHHTDN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Aug 2019 15:03:13 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78J0Gb9016277
        for <linux-efi@vger.kernel.org>; Thu, 8 Aug 2019 15:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=smtpout1;
 bh=Lv8UdoveyIJ8Sakg6VifFqbQiw/C2udDJNIslUb/aM0=;
 b=Z4nwOmOC4ubSyojkacZo/lSgBXe+EngQu05DR6kXWmA5kUgwmurFpdOa7hZ+7L3PXPAj
 XGDg9rVRFOKm6RwUfcnbz4z+U5MLu2hHI6B9njbZcjzwrDbL62QQDIvpwdKY50nOpFOZ
 VuNVFwA981J7D0v6PtE1U0nRyBdLzVCy/fu9GmfKJMvvRiFKgMbaPF5SsUrB5+qTWZK8
 Ua3lcrQgFpRp6kKQWj8XrhqrX8PxsmAa4QWyp1OPfc6qy8Ynt1ByyBCqL9ZTsTEN5Emj
 nlVaQ932m+qWZa9kiR2lKeQ8kh7EKtk/O94jhc284kcMXLVBcV3TJKmtkPGEKYxwenvB yQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2u83vcnfwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Thu, 08 Aug 2019 15:03:11 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78J32OE072176
        for <linux-efi@vger.kernel.org>; Thu, 8 Aug 2019 15:03:10 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0a-00154901.pphosted.com with ESMTP id 2u54whmc63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-efi@vger.kernel.org>; Thu, 08 Aug 2019 15:03:10 -0400
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1451371318"
From:   <Narendra.K@dell.com>
To:     <ard.biesheuvel@linaro.org>
CC:     <Mario.Limonciello@dell.com>, <linux-efi@vger.kernel.org>,
        <pjones@redhat.com>, <Stuart.Hayes@dell.com>
Subject: Re: [PATCH v1] Export Runtime Configuration Interface table to sysfs
Thread-Topic: [PATCH v1] Export Runtime Configuration Interface table to sysfs
Thread-Index: AQHVN1GRuuFZ1FIGT0iRonG1BybW8KbGCe0ggCltsgCAAUDSgIAAtHGA
Date:   Thu, 8 Aug 2019 19:03:03 +0000
Message-ID: <20190808190245.GA2270@localhost.localdomain>
References: <20190710185853.GA2645@localhost.localdomain>
 <3b26bccb3caa4360a552f1dc57b9ac24@AUSX13MPC105.AMER.DELL.COM>
 <20190807130840.GA2147@localhost.localdomain>
 <CAKv+Gu8-BTwpFz0dyNDoAP9xhrDQH4Qm0m73uAi2T0ckVrR5tw@mail.gmail.com>
In-Reply-To: <CAKv+Gu8-BTwpFz0dyNDoAP9xhrDQH4Qm0m73uAi2T0ckVrR5tw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9C8C04D83AF90947BA86CC23959FC7DD@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080171
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908080171
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 08, 2019 at 11:16:55AM +0300, Ard Biesheuvel wrote:
>=20
> On Wed, 7 Aug 2019 at 16:09, <Narendra.K@dell.com> wrote:
> > On Thu, Jul 11, 2019 at 11:00:37PM +0000, Limonciello, Mario wrote:
[...]
> > Hi Ard,
> >
> > Does the version 1 of the patch look good ? Please share your thoughts.
> >
>=20
> Thanks Narendra,
>=20
> The patch looks mostly fine. I have pushed it to my efi/next branch,

Ard, thank you for the review comments and applying the patch.

> and I will let you know if the autobuilders find any problems.

Ok.

>=20
> One possible enhancement would be to defer the second memremap() call
> until the first call to raw_table_read(), so the mapping only exists
> if you are actually interested in the contents of the table. If you do
> decide to make any followup changes, please send them as delta patches
> against https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?=
h=3Dnext

Ok. I will work on the enhancement suggestion. Thank you for the
suggestion.=20

--=20
With regards,
Narendra K=
