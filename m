Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD725AA89
	for <lists+linux-efi@lfdr.de>; Sat, 29 Jun 2019 13:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfF2LmW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Jun 2019 07:42:22 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:43862 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726874AbfF2LmW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 29 Jun 2019 07:42:22 -0400
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5TBdkQW011784
        for <linux-efi@vger.kernel.org>; Sat, 29 Jun 2019 07:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=smtpout1;
 bh=g24IepDSSmZwRV2i9t1tnPLhH+p7lHg154/h/4cAMCM=;
 b=ECC5cX489Wre7NRgRo/8T1OuI/eRSFwDbYg9dGoXU70kOsgA7D9fn+LrfGW6bhUcAo5q
 8zNc36mX4XTEcWOPZ1+TYzcBjGtpEIX34QAgeYyJr/HPWRlklGZ3J/hx1CHciLtcBsR7
 7Xs7E0trOT/WZlU+SgjWaQFSpUTi0gCxiqE2+Lo1kqHQmmT/0XmUrFlejWCrYODFpbjQ
 HHkn5DDcr1kHiFvc4dxiKY9d3fQd0tWxbBS9ZDYGy98cfc/q63mKFw7AKqR6pkoqE2sI
 NpFWI/SkCN4B3tUIVumpPwqVwQrfC7VF7ELPYcgFjSk8y/P0moS6TQiwNgMNXQ1KTF9u CA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2te40k0bcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Sat, 29 Jun 2019 07:42:21 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5TBcdBR010138
        for <linux-efi@vger.kernel.org>; Sat, 29 Jun 2019 07:42:20 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 2te4bf9r8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-efi@vger.kernel.org>; Sat, 29 Jun 2019 07:42:20 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1263256089"
From:   <Narendra.K@dell.com>
To:     <linux-efi@vger.kernel.org>, <ard.biesheuvel@linaro.org>,
        <pjones@redhat.com>
CC:     <Stuart.Hayes@dell.com>
Subject: Re: [PATCH v0] Export Runtime Configuration Interface table to sysfs
Thread-Topic: [PATCH v0] Export Runtime Configuration Interface table to sysfs
Thread-Index: AQHVLm0dISGCw1TyVEKadDoZWf9kr6ayJkMA
Date:   Sat, 29 Jun 2019 11:42:15 +0000
Message-ID: <20190629114158.GA2565@localhost.localdomain>
References: <20190629112326.GA2366@localhost.localdomain>
In-Reply-To: <20190629112326.GA2366@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.1 (2018-07-13)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CAD52FC1C3F8CB419026875B132A9B18@dell.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906290148
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906290149
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jun 29, 2019 at 07:23:26AM -0400, Narendra K wrote:
> From: Narendra K <Narendra.K@dell.com>
>=20
> System firmware advertises the address of the 'Runtime
> Configuration Interface table version 2 (RCI2)' via
> an EFI Configuration Table entry. This code retrieves the RCI2
> table from the address and exports it to sysfs as a binary
> attribute 'rci2' under /sys/firmware/efi/tables directory.
> The approach adopted is similar to the attribute 'DMI' under
> /sys/firmware/dmi/tables.
>=20
> RCI2 table contains BIOS HII in XML format and is used to populate
> BIOS setup page in Dell EMC OpenManage Server Administrator tool.
> The BIOS setup page contains BIOS tokens which can be configured.
>=20
> Signed-off-by: Narendra K <Narendra.K@dell.com>
> ---

Hi, apologies. I missed mentioning that the patch is created on the
'next' branch of efi tree.

> RFC -> v0:
>=20
> - Removed rci2 table from struct efi and defined it in rci2_table.c simil=
ar to
> the way uv_systab_phys is define in dmesg.

Correcting the mistake above. It is defined similar to the way uv_systab_ph=
ys is
defined in arch/x86/platform/uv/bios_uv.c .

> - Removed the oem_tables array and added rci2 to common_tables array
> - Removed the string 'rci2' from the common_tables array so that it is=20
> not printed in dmesg.
> - Merged function 'efi_rci2_table_init' into 'efi_rci2_sysfs_init' functi=
on to
> avoid calling early_memremap/unmap functions.
>=20
> Also, a note unrelated to this patch - compilation error is observed when
> testing with make defconfig related to uv_systab_phys in
> arch/x86/platform/efi/efi.c. It seems like it needs to be protected with
> CONFIG_X86_UV in efi_tables array.
[...]
--=20
With regards,
Narendra K=
