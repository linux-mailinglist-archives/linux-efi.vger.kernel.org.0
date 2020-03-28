Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E09B196A1C
	for <lists+linux-efi@lfdr.de>; Sun, 29 Mar 2020 00:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgC1Xzr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Mar 2020 19:55:47 -0400
Received: from mail-mw2nam12on2136.outbound.protection.outlook.com ([40.107.244.136]:45632
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726604AbgC1Xzr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 28 Mar 2020 19:55:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKIshp/prg32YhIplH3vBiCCpRa4qBKR1FDBPh6PyDObXVtaI6MJ08aSHRqsgFwedMNJKyDNtEhd1NGL2KmmS2rPW5iMwuQsebVa0pK0e4NL5yYxaRMimH6QVA2vchrW9DgAg5DQMposxujeZ37V/Dqrua+57RBxzzyOOn4nO9kYYfr2+YIMiNeBasJMo2KzVEnSBGzTRKpajdSkhjF1luDbfChTfV29CorAURI59euFZpUI7P8DNi0fz4ub5POBG3OVgu42I/me+6DwqXgpXJdAPMpZeIpnyTjIG9F9Mv9ERdFF7Y90X1mpjc6AUw/vG0rqgvp15NN15EWFi6Z9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lRhy5H+eHseY8vvcQdIkPICe08jxD0kIjq67yQDt78=;
 b=Tg0SLhszEZyKB4rKMaaLJ5HeiKf/sjKAo07lwDW3k4t/CH330h3hYbVnQT9At8fcIPtiusyVKJve/q92nnSe8NYfeqABkS/RQxGDzfiTvuq/4Cahftzztz95Hh52XWhaH8ZPriI0DzSQSQ28NozWwsk/XOUiHJ60PZMaQ6Cl6+y/lAJp0aSan0/SCRBye1kltQgNZm/vnfiIBoPizV1wBtCbJ5B6I9kqMvJHt1PQXSbJRNk8csojIDf6VhRUTd3QEo+8OWzQunTuWNIl5cymN7RedIKTzBVCXzEXDKD4u0JyYQcJ3sN3leaQPpY0f60fuguebjS400nq1ExYYIDFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lRhy5H+eHseY8vvcQdIkPICe08jxD0kIjq67yQDt78=;
 b=Fy05FEHa/aK096tDwG6oUZolkaLVQnFBwLhNDtQ/yth7gPcAB3qSfpvbCgisYCTzgA4/hq710MlhDCimnHAleFTpH7svVSzccO3O4hc6KC8hQhmScAWOw3RVq5ZNr0hg1YePvA8K3+AsBAsDLFSZra2eP6C+Rzh4z4DNsAdrLls=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0907.namprd21.prod.outlook.com (2603:10b6:302:10::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.11; Sat, 28 Mar
 2020 23:55:22 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%8]) with mapi id 15.20.2878.007; Sat, 28 Mar 2020
 23:55:22 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "leif@nuviainc.com" <leif@nuviainc.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>
Subject: RE: [PATCH] efi/libstub/arm64: avoid image_base value from
 efi_loaded_image
Thread-Topic: [PATCH] efi/libstub/arm64: avoid image_base value from
 efi_loaded_image
Thread-Index: AQHWBUObXv2MTW3u/Ue45F8yahNJA6herKsQ
Date:   Sat, 28 Mar 2020 23:55:20 +0000
Message-ID: <MW2PR2101MB10525BAFA3880DD27216C4DCD7CD0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200328205809.23825-1-ardb@kernel.org>
In-Reply-To: <20200328205809.23825-1-ardb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-28T23:55:18.6548410Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9532f6a0-0497-412b-9431-a84c828d4b73;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f036d26e-6d83-4e6b-52a0-08d7d3737a69
x-ms-traffictypediagnostic: MW2PR2101MB0907:|MW2PR2101MB0907:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB09073218C9DE3EE808F08D67D7CD0@MW2PR2101MB0907.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 03569407CC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(66476007)(76116006)(66946007)(66446008)(110136005)(478600001)(2906002)(33656002)(107886003)(71200400001)(9686003)(54906003)(10290500003)(26005)(8936002)(52536014)(82950400001)(4326008)(81166006)(186003)(64756008)(5660300002)(316002)(66556008)(82960400001)(81156014)(7696005)(86362001)(8990500004)(55016002)(6506007)(8676002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1PrlkUx9RAwSoKajjM3B7Lc7iFeIYtOaNy7C70Ha4zpMY9/LFy/avSfo+b2ov5N2/WJgLP591OXCIfd8K2pFwFZn6msLthcDHsXqUr3bl5xVok5i0k8VTHnw6MM0X7PqlcHZgT+CFMc20nomqyeGZQBeTBsWDaz86D9Sqn7vgipu+09p6s19SM5h3CM9d4QVZcZ9LWyDAz5jcWsY4EDGKZpEDxtqE0WlRfg/aky3L4B43xZVF51eRv/bkRCAzqDIrN0/yzUljxeXUXm8v1T43n+b4cYurmO9iU6mPmbNyxC22SCs47hzVP1pVZiSWjqs/5CpOwmNkEYtebIyIj5xJLot2TTVS/xzp6fFNVtZKxZcN68lmkNtr5NcD4KbEPqY1FbwkgVqnAFuQasNzBCB7o/VADJtnsoV7IP+Z4pnCIZs0XBv6Tz4LkJMVuKryLs
x-ms-exchange-antispam-messagedata: 7EXXnLqfx299yVQbfNOot6iWHAWwdOQpwRg5dDO7arV+EamouwOpE84sMYl4hKeSWNCKxR+/F0axbKyeN6QI5bnN6sF2CN5H7pwFhesB+HnLIEl5x4AyJUvFdCgUfBOiRDcC80BSkiUsvs03/ZjHmg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f036d26e-6d83-4e6b-52a0-08d7d3737a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2020 23:55:20.9145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dM26I7bjVh1uiTeDGSjPVU3jy4neeujgpT2kouBLfcCZCsOKsxCQEWKc+d0ZfIRSItNz8Dt5s8WY3oZBIMT1fzAAPVmYPJwgAzcMBJ1BcG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0907
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org> Sent: Saturday, March 28, 2020 1:58 =
PM
>=20
> Commit 9f9223778ef3 ("efi/libstub/arm: Make efi_entry() an ordinary
> PE/COFF entrypoint") did some code refactoring to get rid of the
> EFI entry point assembler code, and in the process, it got rid of the
> assignment of image_addr to the value of _text. Instead, it switched
> to using the image_base field of the efi_loaded_image struct provided
> by UEFI, which should contain the same value.
>=20
> However, Michael reports that this is not the case: older GRUB builds
> corrupt this value in some way, and since we can easily switch back to
> referring to _text to discover this value, let's simply do that.
>=20
> While at it, fix another issue in commit 9f9223778ef3, which may result
> in the unassigned image_addr to be misidentified as the preferred load
> offset of the kernel, which is unlikely but will cause a boot crash if
> it does occur.
>=20
> Finally, let's add a warning if the _text vs. image_base discrepancy is
> detected, so we can tell more easily how widespread this issue actually
> is.
>=20
> Reported-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/arm64-stub.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Tested in a Hyper-V VM.  With the 2.02~beta2 version of grub,
the FIRMWARE BUG message is output and then Linux correctly
boots.  With the 2.04-4 version of grub, Linux correctly boots with
no error messages.

Tested-by: Michael Kelley <mikelley@microsoft.com>

>=20
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c
> b/drivers/firmware/efi/libstub/arm64-stub.c
> index 9254cd8ab2d3..db0c1a9c1699 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -116,6 +116,7 @@ efi_status_t handle_kernel_image(unsigned long *image=
_addr,
>  		 * Mustang), we can still place the kernel at the address
>  		 * 'dram_base + TEXT_OFFSET'.
>  		 */
> +		*image_addr =3D (unsigned long)_text;
>  		if (*image_addr =3D=3D preferred_offset)
>  			return EFI_SUCCESS;
>=20
> @@ -140,7 +141,11 @@ efi_status_t handle_kernel_image(unsigned long *imag=
e_addr,
>  		}
>  		*image_addr =3D *reserve_addr + TEXT_OFFSET;
>  	}
> -	memcpy((void *)*image_addr, image->image_base, kernel_size);
> +
> +	if (image->image_base !=3D _text)
> +		pr_efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base has bogus
> value\n");
> +
> +	memcpy((void *)*image_addr, _text, kernel_size);
>=20
>  	return EFI_SUCCESS;
>  }
> --
> 2.17.1

