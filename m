Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7664F380A0B
	for <lists+linux-efi@lfdr.de>; Fri, 14 May 2021 15:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhENNCa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 May 2021 09:02:30 -0400
Received: from mail-mw2nam10on2068.outbound.protection.outlook.com ([40.107.94.68]:3866
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229459AbhENNC3 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 14 May 2021 09:02:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eI/0yBWCRaFMxaYOCiVv9BWyLZFbC/LJDYe97VhaZ4frwS8p03YvitEWB3tnwKyeUDRhIe7tS4Nmcp5mVOcchcCE4IRYUPHWkNSHTebtpEvdZ7FOXuNbourGSIJJRwdyVepJKlhd99EEYaSHgrcFwlZvJGbJrr0sbL2/ihyHXyIEVnURjT1Q9Ks4SAY2u4FYHWudY0+t9ZMeig0bHIh7QTqVgi0711OnaNcFU5H9Ccb6Q/Vaqsuln6T9ABpuhyOWe8ajI5zPXKTmuPLMxu+sbIUv37Kf3Mkrz7irkiqCHCEI6UycgvgaO4C+sq3q4LOLhXhrGuDeEwdm+TaH9pxBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88x5JIdkJvlwthFz+4qM0nrStA9ugJfC1LYdowX++Sg=;
 b=MjzVT+cJW88u+5FYGyR3dlULAR1nDwnq96WFfr0TA2YATP1ZhWXNiOiyBHcU6vqmEDpGgo0Q0rY74p4yxx2JAZoK/VBfOjRdBEiuX1/Bk6JuiRmW9ldMylgkTCriK0GiD3Dd6UAWUVX/lYBz9Y6C4raZI5qvGds1Makm2s119+NTogSY8fXsgxlnt7xrpwFfkBRvc8PQtspqVGEm6kOvAKwwMejUFvCrYakmwIBFjBZR7v/jDbznmd8Mz3PwaA4NjmcIzn/kx+Edmk+pmQwDOhUmsjoGRLUabUAFtuRYqL4ZJYsIcncQ5HFIFruUzuXQJ5HiGgaZ8dTNXgs7PJWVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88x5JIdkJvlwthFz+4qM0nrStA9ugJfC1LYdowX++Sg=;
 b=EYja60awWA1nmTX9wT3HZJZUkvWRMSSB9WychqtDnNw1E4Vg3ntcYLFDFQduvQQDviUC+Z11V+ThSiOCfRvEMs0yOzSsd++pZSNo9PmV9MRLPQII5d54ge3ucTOgVG5iuCDEA+ouydv74SLblEQWODBbMSU2aLnHDSAHPl7WYqk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2717.namprd12.prod.outlook.com (2603:10b6:805:68::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 14 May
 2021 13:01:15 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4129.025; Fri, 14 May 2021
 13:01:14 +0000
Cc:     brijesh.singh@amd.com,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Allow access to confidential computing secret
 area
To:     Dov Murik <dovmurik@linux.ibm.com>, linux-efi@vger.kernel.org
References: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <2c8ae998-6dd0-bcb9-f735-e90da05ab9d9@amd.com>
Date:   Fri, 14 May 2021 08:01:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN4PR0601CA0015.namprd06.prod.outlook.com
 (2603:10b6:803:2f::25) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN4PR0601CA0015.namprd06.prod.outlook.com (2603:10b6:803:2f::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.32 via Frontend Transport; Fri, 14 May 2021 13:01:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af63d762-bd47-4af6-cff5-08d916d85afa
X-MS-TrafficTypeDiagnostic: SN6PR12MB2717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB271724DC5033C42C7D7556C0E5509@SN6PR12MB2717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oavu/bQl8GrUP2bqgUXo4nfTK3LLR6PTYCIVH2miHSCwbwwjzFdTPcl/sjmPHaXqMeyOe6zSzc4OMALf9YPPwlrdpHz36+eZ+7Zhy85ZW5eESbGF+JOZ9I4aV8xf1pt5UYd7mU8FioB5dhji3b0y0sa1adCYSDGJlc2UJLyC2ZzpkIZ/fdxkdtF+03DnrpPnFBYpn7PZsPcCfaYSLjfuzdAFyosn+8xFib/avY2TTVrtXZofjwm746G6dpceVyIMboA7mCb3yWaznskEpLsGu8QBXebUk4eVElYSSZRREmGop2bJW8025uRrl3EJ0u5Ge0vl2gZpXMAA+tflNUq7Wk6Zd44VXfjL96ZEBz7xK7zZ9S3YHfNJnbVKYq+cmg+RuaWTWJOdbQo9QGHskHa7Kb4AaFVrPxmmyeZAD0t31XoUcA0PXRdjBHtolvGGR06071PglqtpCruEbAKTxgRCuLKLJmHFJLODAHkPAANsage91n0aUUeAMdcv8fIv1KwVsvhTiq++fP9tdDn157P4du00QfhKjenRTNNES/kgu/zl0e1PcPsJlsdfCMOWdT9mp+E+/N+hSI8stIZjLverGYa2jiRvbIk2Oe7yRs3g2cat9axCHB6rYjUA+RK5Aioj2AZDYm8z12VlOGKCpk5KnMeWPVKTVKcq60o0sWD9QG51uqqhXaiSIAoyRvccFjyziJ9NlqzuxdvxC6rEJ6wtUSZ8Y51iDyiptx/maod00WN7zKcoURhXoLMWhKooXSQPnSqfRx6NQsGBWCsituAQBCW3T+xD+lOECRy2gmW0EvY6UBuKxzcBlnRuKuWdK/Uh+nx/HwagArDF2l95hj/K1SoEQs5yoc6qB3B3IyCxx82iLSFYaNjQsyl1MNtgfbxoKesJKaVQ4H9swWVv14blYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(2906002)(66476007)(66556008)(36756003)(66946007)(316002)(54906003)(966005)(38350700002)(38100700002)(16526019)(5660300002)(478600001)(53546011)(6506007)(86362001)(4326008)(6512007)(186003)(52116002)(44832011)(8936002)(8676002)(31696002)(7416002)(83380400001)(31686004)(956004)(2616005)(26005)(6486002)(219293001)(43740500002)(45980500001)(6606295002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a1ZUbGt5OUZCcTFrc0JVSWpiUUJxM29HRENPRERzQ1dvSk4wZHY0aGxEbDdq?=
 =?utf-8?B?Sm1tMjZlVlZDa3hiWjRhVHV4NEtUZitjbzdSMVEzWEU4K0lsQlNRcjdPcyt5?=
 =?utf-8?B?TzE5WlI5encvT2xUQUp2aGFVQnYwQ21yQnlqOUFPQTBSK1NyNjU0bjRPa2RU?=
 =?utf-8?B?RzZtR1o4OHRZbEhkbTBpdUZ1UU9jSDlRZE9MVG9oemduL2RBMGJvakZRdml4?=
 =?utf-8?B?NnRkLy9qTTR2b1JlR3RJWXhMdlNzenVsUjYyNjltV1h5TUNGSmxGMlJ1bWU2?=
 =?utf-8?B?aGFqOCt5UXBSbDdEM0tZZVp3c3ZZY1Fxcm1sN0FYUlNmQzhicGJOSHA4anIz?=
 =?utf-8?B?UUd1TkRCWmRPbzRNN2JsYlZLOUMvOTVieVUrZVdPQkZ2YTJLbmVqQ2NNS3lz?=
 =?utf-8?B?ZkFBTmpObFNVbkhpVEZUS3UxSmF1VG9zRElvbEJKdEs4L0oyS1I5UjN6NW81?=
 =?utf-8?B?SG45QkNKVWVlRElKbUwwWVEwUWw4bG9wV1hLZ096cmRhR2pSbEFPTk41S0tX?=
 =?utf-8?B?NnlXRkZIV2VoODErbzUyTmpzajJQdDF3aHhkRUI2RVJGU0lKVk95ZXZXSE5O?=
 =?utf-8?B?UWl0TTQrem1tT1NvTm1Tb3NBWlRmWmdEenNPWmNDVmF3b3pBR1c0d2M0VXZO?=
 =?utf-8?B?b2lWNDcyd3hxL3gyMExjZjNxT3VwcDBxekdYaHJocjMxRzlweTYrdGZCUnBr?=
 =?utf-8?B?cE9mSGw4QXlwV3dGOHN0VmdSaktOZzRGVXhSSUdyWmhPWkkzenA5NzluYWJ5?=
 =?utf-8?B?M3AydVNTWG4xR2s2R3o3cVZEU283OGVQVzE5Y0Jib0RublU4QlArZUc0cXpY?=
 =?utf-8?B?MTByNExvN1ROSG5EVWxpc25XNmJwY1MwMFpVMnBhSXlQSytsM0pmVlg3Ti9G?=
 =?utf-8?B?bTJNbEZJaEJOVGJWMzRVaG5SRm9CTFU3b1UrUkNOVWE5UzM2MDF6eFpjQlN1?=
 =?utf-8?B?Z2RIYkx6NXB6VmQrcVdyMXpSWnNuRzBNbGdTR0RYd2tJU2RYZDhhZTZaOVJ5?=
 =?utf-8?B?NkNrdWZtZFI1MUJBKzBadlE0TTdsZndwVll4R1dMOTBPK2JBVzlkNWt6SDM1?=
 =?utf-8?B?TnhndldaOUdvYTNOWHdZV1QxcDZmUXpOZm5yVVF0Y1EyYWJrL1JRUk4yS242?=
 =?utf-8?B?Wm9rRE14REVnV3RVU0hOaWpkNno0VHl5QlZ6WVlsWnFwTnBLLzRxbVBITUxu?=
 =?utf-8?B?MWJlbW5pZXRRS3A5RHRNai8yZkdxVk9paUtRR3F6a1RCc0xScC9Sd29SWm1w?=
 =?utf-8?B?TXZKdEdQRGhNNzF6Tk9YOG9OYWJNOHcwYkt0OU9RTERhUS90TXZEQ0Iza2oz?=
 =?utf-8?B?ZTFQbkVVblN5d2txUVJTSk9oREtJZk5BeTFxcUpWUU1ZTE9VV1k0eVFRZTM1?=
 =?utf-8?B?VjRXejByUlMvVDI1aFpxcGJMNWZLcUgwaEI3MGQ3VGtBK3NqWUt1YXhtdmFx?=
 =?utf-8?B?M0FHc1laeFVublNJWDk1NUljR0FKM3Y4bFBRK00zYTE4dXl0MnRjcTRhTHlM?=
 =?utf-8?B?VWRmMFdINFIyZTE0dFNLRC8rSlVDd0d1bGNBK1hkQU9XSzdVOVZ5TWUreUg5?=
 =?utf-8?B?bnNHTjJDK2xmbmVwRXhQejNYamlneFk0bUZJeFZwUTJSalRZcEYrWEdjMzdh?=
 =?utf-8?B?L0tsMHlVUnVVcUNvaDF0djg3QlhEakYvelZjQjJBOXc5QTFqRnl3UFg0YTJS?=
 =?utf-8?B?bmlKcU9rZXFuekZNMkpDOEVhUHZobVNtWFZZbnVBVTBJcG1PZ1RQWFBVeUNU?=
 =?utf-8?Q?fXMMy/DzgB1SkQIflAD36V4Nz0qE+loQmlI37CH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af63d762-bd47-4af6-cff5-08d916d85afa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 13:01:14.7008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AQRIqJ4XDkaelAJ2mUnP9yhnPpxuKPSe/eSodTKMuGu6Bmt2FWhqk+EQ+d8KNIsRKSfC1BokUF/1wC98rTXRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dov,


On 5/13/21 1:26 AM, Dov Murik wrote:
> Confidential computing hardware such as AMD SEV (Secure Encrypted
> Virtualization) allows guest owners to inject secrets into the VMs
> memory without the host/hypervisor being able to read them.  In SEV,
> secret injection is performed early in the VM launch process, before the
> guest starts running.
>
> Support for secret injection is already available in OVMF (in its AmdSev
> package; see edk2 commit 01726b6d23d4 "OvmfPkg/AmdSev: Expose the Sev
> Secret area using a configuration table" [1]), but the secrets were not
> available in the guest kernel.
>
> The patch series copies the secrets from the EFI-provided memory to
> kernel reserved memory, and optionally exposes them to userspace via
> securityfs using a new sev_secret kernel module.
>
> The first patch in efi/libstub copies the secret area from the EFI
> memory to specially allocated memory; the second patch reserves that
> memory block; and the third patch introduces the new sev_secret module
> that exposes the content of the secret entries as securityfs files.
>
> This has been tested with AMD SEV guests, but the kernel side of
> handling the secret area has no SEV-specific dependencies, and therefore
> should be usable for any confidential computing hardware that can
> publish the secret area via the standard EFI config table entry.
>
> Here is a simple example for usage of the sev_secret module in a guest to which
> secrets were injected during launch:
>
> # modprobe sev_secret
> # ls -la /sys/kernel/security/sev_secret
> total 0
> drwxr-xr-x 2 root root 0 May 12 18:03 .
> drwxr-xr-x 3 root root 0 May 12 18:02 ..
> -r--r----- 1 root root 0 May 12 18:03 736870e5-84f0-4973-92ec-06879ce3da0b
> -r--r----- 1 root root 0 May 12 18:03 83c83f7f-1356-4975-8b7e-d3a0b54312c6
> -r--r----- 1 root root 0 May 12 18:03 9553f55d-3da2-43ee-ab5d-ff17f78864d2
> -r--r----- 1 root root 0 May 12 18:03 e6f5a162-d67f-4750-a67c-5d065f2a9910
>
> # xxd /sys/kernel/security/sev_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
> 00000000: 7468 6573 652d 6172 652d 7468 652d 6b61  these-are-the-ka
> 00000010: 7461 2d73 6563 7265 7473 0001 0203 0405  ta-secrets......
> 00000020: 0607                                     ..

I am adding a new virt driver to help get the attestation report for the
SEV-SNP guest. I understand they both are different, in case of the SEV
the attestation is already completed and we are simply exposing the
secret provided after the attestation to the userspace, whereas in SNP,
the userspace is querying the attestation and will probably derive keys
etc based on the attestation report. I am wondering if we should merge
both the SEV secret and SNP attestation query in a single driver ?
Should we cover usecases where SEV guest is not booted under the EFI ?
Also, it appears that this driver need to be manually loaded, should we
create a platform device so that the driver binds to platform device and
use the resource structure to find the location of the secret data?

I was trying to answer some of these questions SNP series. See these patches

https://marc.info/?l=kvm&m=161978514019741&w=2

https://marc.info/?l=kvm&m=161978514119744&w=2

https://marc.info/?l=kvm&m=161978514219751&w=2


>
> [1] https://github.com/tianocore/edk2/commit/01726b6d23d4
>
>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Ashish Kalra <ashish.kalra@amd.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-efi@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> Dov Murik (3):
>   efi/libstub: Copy confidential computing secret area
>   efi: Reserve confidential computing secret area
>   virt: Add sev_secret module to expose confidential computing secrets
>
>  drivers/firmware/efi/Makefile                 |   2 +-
>  drivers/firmware/efi/confidential-computing.c |  41 +++
>  drivers/firmware/efi/efi.c                    |   5 +
>  drivers/firmware/efi/libstub/Makefile         |   3 +-
>  .../efi/libstub/confidential-computing.c      |  68 +++++
>  drivers/firmware/efi/libstub/efi-stub.c       |   2 +
>  drivers/firmware/efi/libstub/efistub.h        |   2 +
>  drivers/firmware/efi/libstub/x86-stub.c       |   2 +
>  drivers/virt/Kconfig                          |   2 +
>  drivers/virt/Makefile                         |   1 +
>  drivers/virt/sev_secret/Kconfig               |  11 +
>  drivers/virt/sev_secret/Makefile              |   2 +
>  drivers/virt/sev_secret/sev_secret.c          | 260 ++++++++++++++++++
>  include/linux/efi.h                           |  11 +
>  14 files changed, 410 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/firmware/efi/confidential-computing.c
>  create mode 100644 drivers/firmware/efi/libstub/confidential-computing.c
>  create mode 100644 drivers/virt/sev_secret/Kconfig
>  create mode 100644 drivers/virt/sev_secret/Makefile
>  create mode 100644 drivers/virt/sev_secret/sev_secret.c
>
>
> base-commit: c06a2ba62fc401b7aaefd23f5d0bc06d2457ccc1
