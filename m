Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A53638CAE5
	for <lists+linux-efi@lfdr.de>; Fri, 21 May 2021 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhEUQXP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 May 2021 12:23:15 -0400
Received: from mail-mw2nam08on2048.outbound.protection.outlook.com ([40.107.101.48]:25953
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230267AbhEUQXO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 21 May 2021 12:23:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlXwzIX+a2fdQNv/TSYfGvPURegDBl1qkiaiF0lyhNzIWrc9+lZ/E+8crsCIDpi24RH+FPsHW0KWuVgs0sPUZhTFKlfYEjU/1Xh77QQ8Z/mRwoZM6KVAtJAOTBUDVu59Qzw/Xzp1yYd6jlUOlJxYa9FFmIHG8+Yic/5wSL+v5SA/6M4j9OmJfcn6MJn6Qw0YqnYNaG9FrlQUDV7L4WrRdxoxBxmTg1QXvkxNlEhPNQT7HWvE4HaOkvAvWCeuRCbeSBtXshWp1qdoz8SlaZP3N10TRLo1bJxs97aR9w02WOfpfkdk1nE/zH1sJ4Q2kfRyP5oZib7szWdw0OE4mvhqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Stc0p+VyyYlvQZp0igWCl3NnvLsWi7NNSP5HExdAvZ4=;
 b=cI7BdBGFsJvIOUXsNLMyylOv4HtEfDqwt5Hij2c9EWtGBPAH2quT9EmfGj9uEE3P9Mo16dqFxVuvTsELi16gZ2WNe/Ox9YFJ0u0qwMYafQaIW5K02R20FXZW1C2i6AM2H+RURParKncQ61SC7Rbl09fGpwyNkECHXB7xndo7bivfALCpjAm1aWQnrHyF2jt9mgAglM+fPIxr7oYIfGHTWivj2cvN8lMV+8tnzbvh7RFqkD6NkTWhdDBXQDZT4kCUvbWD5qbRQpSwTMabSE1dc015BhGSLXa+Dfo3gIHFldOb6KGeRYnBBxSnUrzse8UCYGYqy8JRMghgoL45cUz8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Stc0p+VyyYlvQZp0igWCl3NnvLsWi7NNSP5HExdAvZ4=;
 b=felLlT4/Fy0WdAR3SkGCoy4JGqb43MnilV7AsXoVD+J0wcKHtggXXQE26UzbAirdE7uab+xJwD0Et0ZqDccd0CdeTglcQ4bptuOO/ZVJFFeR0gChsBMZkVDT02t0/leg0Fo+2wKUtgj7Zu15c/fdTuChhZCIQTO48voFnMUsMOo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 16:21:49 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 16:21:49 +0000
Cc:     brijesh.singh@amd.com, Dov Murik <dovmurik@linux.ibm.com>,
        linux-efi@vger.kernel.org,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
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
To:     jejb@linux.ibm.com, Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
 <2c8ae998-6dd0-bcb9-f735-e90da05ab9d9@amd.com> <YKZAUdbikp2Pt0XV@work-vm>
 <ccdf0059-7e39-7895-2733-412dbe4b13f1@linux.intel.com>
 <c316c49c-03db-22e3-0072-ebaf3c7f2ca2@amd.com>
 <d6b991603d79cfbaf05c93f8b662860b865d861b.camel@linux.ibm.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <d9318d06-8565-caad-e226-c2234210a6d6@amd.com>
Date:   Fri, 21 May 2021 11:21:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <d6b991603d79cfbaf05c93f8b662860b865d861b.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN6PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:805:f2::15) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN6PR04CA0074.namprd04.prod.outlook.com (2603:10b6:805:f2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 16:21:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae5c73b2-3ae4-4612-29f2-08d91c7488f3
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2767BBD9F0A99A689B0E53D9E5299@SN6PR12MB2767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kSHhu3p+gMXpVrIfjP6HkzdxQv+LflOBcW2ebR179ZZHvJLBAUHUIsdmfsNdjVpqS6OVaBSIyUejhg68dejQGuc59jhjHDszinxiObzQjdNYzn4az4dz1LdFUV9Dxx8pXp9Jr7I54MbKg/sWEtU//lAhfO0I52mYMhpHnwrxra64fpQdgXYFEYOVCAYl2zIHwY5csnvIQPZHQ8heQVWTHJtgCFSpr/cllPacE9piXHCWLzWPe6/kUCosUK13q0qijlEyX9kkSEbvuHtIAcMS6+/MLm8LBclTVovEeDwN4O2VS0J/YqRvjO+z0o/SaWbUQ5dxiapHAqDZdtIjxDK7bHLzLGqih2dzmgnTTr3iyUvZ+4SqT3bj3NujtnIhpNw46RyW9x9PmzS1RTZgCoK5xzl4I1f1IVFnSq+h4jcGZ1kBFgDarJZOIKuqIkQORNtMePSBABHCc9yEgQQJM21K/SETQi3Y6d3Llid48d5k3b7Tu+Z0JCQOcy0TxChN5L9NDVqnLexI7IyGZNO3hNz0UzTUQfczUmR25BTBSCIDHD2zSYA2bhvnQ188rrzE5lmboMVIvSH+pTyXN+W8QIydCuxd0UVsudrT5kWdyeG/WxEVQIei0D87EIasb6uqpBmpls+pIz/vDJ+27OoRbKAh3RWhGprZ5WllfZ+32QzKreW0z4nje8/TEK86gyVmw71M97yXuXGMrBc941RH7xQi+SwT9aq3howbm29f0O9TIwKUcT4nz7u120fTxe6xrJGw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39850400004)(2906002)(316002)(2616005)(31686004)(6512007)(36756003)(38100700002)(86362001)(4326008)(83380400001)(52116002)(956004)(26005)(186003)(5660300002)(16526019)(54906003)(7416002)(53546011)(6506007)(110136005)(478600001)(6486002)(8936002)(66556008)(66476007)(31696002)(8676002)(66946007)(44832011)(38350700002)(219293001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y2JKUjJ1bnQzclBSTzdkeXIvTzIxUnV3ZzBXcFdrSmJXRjR0eGwxV2poS0RD?=
 =?utf-8?B?MkFwZ1BBM1UvdUw3QmttZTlsNGZGOVcvL3hJLzhxYzg1YXdCbjJ1Q0p4dDFS?=
 =?utf-8?B?N0UzV0JpYnhqQjRlT3BTNWFLcnJqVDIzT3laYVFtcXpPSnlweW12NW0wTkcr?=
 =?utf-8?B?MjFrSU9RaVFScHljYkRpcHdNRDRoL3BvWWVEMklXR1g0bVlUcEJIeXFsMmxU?=
 =?utf-8?B?MlZvM01PYnpKNnk5bHZubWhRS2FlaFBKRDNGOEc3b1paczFUc1ZBWHowMENG?=
 =?utf-8?B?L1pkdnhhTk5kamtjNkVacThIcmphaEZlMlpoQittSEpzMnA0MFdNSWdYRXp6?=
 =?utf-8?B?cG9PSkUyc3p5UmFrOHhJNHlqSkFZQlNyTlBHTFZwcm5pTUlMR2RncklSbU9O?=
 =?utf-8?B?VEQxNE9CcFR6YTNjYVlNZGExa2ZOb2l1WFhmeklhRjc3ZGd4SnZpdm8zaUZ0?=
 =?utf-8?B?MnZzdXp5eU5VOGlsWmI3Y0NObnZER2s5bDNuaXA3eTBuUDVMNDkvTFRyK28z?=
 =?utf-8?B?cmdTa2ZxRWdiaUkxMkRYY2FBM3YvT0pDNkgyV2JFVjFNbFdabWQ5MDRneGNm?=
 =?utf-8?B?d0lsS1BpRU1WMTkrTFR6c0tYWEUrL0VmYVNIMzY0RG9FWURTb28yYnJpdjJE?=
 =?utf-8?B?bTZTbllLV29HOUplOGw0UzhTdk15YmRhTk1HK1hVS2ZrOGV0eXVHUEx1aGVk?=
 =?utf-8?B?V3g3VTFiUkRLbG8yM04xMTF2azR5VXI5b3doaUVkNXB1d1pJaU9MOWd2a1A2?=
 =?utf-8?B?bWgwdFRoMHRwUjN6b2NDTHdMOGNLYVNYbDV2YWcydVhRSVdoRW1HcGxXL3E5?=
 =?utf-8?B?VDVlTHJsNE5JajQ1R3NMa0tpVkdMVWxNZm5NSGNPOFpnYUNwUmdvbWlNUEM5?=
 =?utf-8?B?amdUaFVORHE2cE9Ld0drcjYxZFI2UHRpcU5FOUJVaVFZQ29iMjlhV3ZXWGN3?=
 =?utf-8?B?Ky9yV215QnhsSk5EYjliSlI2cGQrVlJhLzcvWHZWZXFPMml3TGsySzQ4cmpY?=
 =?utf-8?B?SkcrQnU2cFpjQ2dkQllFbFNXSCtEWUZsVkVzVzVzeUdleGNJVDlwM0F3Zy9i?=
 =?utf-8?B?b1JnU1VtZlJ3UmNPWWhpemlCRlpaQkJzcjV4d1pldStHdVdTcFRpbldZbUQy?=
 =?utf-8?B?STNmT1JUcEo1Rm5EZkFmWDhMaCtnMmlMT2JmcVFOODZOM3AxdDgzQzVKMFly?=
 =?utf-8?B?OWd5YVpvZFl2YUVJd08vcmMwbnJRdnFXc1VsM3FMOVVSRDRTL21KZUM0TGEx?=
 =?utf-8?B?RTB4UGRLOUFUUVptQ2E0NXcvK205UEhkY1NEWjVoQlFReTdnbWhhdkFVekdC?=
 =?utf-8?B?aVljb3ViTkhuMkxzK1c4TlV4V1UyZmxiaFExQ0x1dzV5cjBKNDNVRGV0NUJt?=
 =?utf-8?B?MEM1aXhsb3FoRDM2M1VPT1ZlSEpneFo3WDRNK0JvZUx4MXBlZC8xa0s5L1N5?=
 =?utf-8?B?ZmtrVENXVnoyZzVSZ3J0S1FOT2ZXOHZack43VUxZV1Y5SFJJek4zVk5oYkdD?=
 =?utf-8?B?TnczaTlDTklDbERqQno4R0xoT1hhU0pJZ1Y4b2cvQk9wbkxwWXoyQlAvYUNa?=
 =?utf-8?B?TDFnQnduUGdzNi9rZEpkSlpMMjZWUVMzcU5RZ1o0K0RLRGZjT0VaWlNqM1FS?=
 =?utf-8?B?dVFNdkg1bFNCNDNkSnpxSGJGTDZxd0tMbFErR2VObTU4bWF1L013MHRZNG5C?=
 =?utf-8?B?ZmpHUXBYTTZGSVhld1cyWG5mT1ZmTjd0UC93KzNPb0tDb3FSRnFlcXRxVVM4?=
 =?utf-8?Q?VFs49uank/MOO8u2UdzuiG9IhHJuWanVAxN0ua6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5c73b2-3ae4-4612-29f2-08d91c7488f3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 16:21:49.1146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNZ8V/TaWYne+mM+bymDWu3AEZ89xa1qwJnaM2o3MynAywIrHEdf2VmFgfBoj5X1XL4zfM37K5VfKljBkcf5yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2767
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 5/21/21 11:03 AM, James Bottomley wrote:
> On Fri, 2021-05-21 at 10:56 -0500, Brijesh Singh wrote:
> [...]
>> In case of the SEV-SNP and TDX, the guest OS participates during the
>> attestation flow; the driver working on the behalf of userspace and
>> does not have access to the secret, so it cannot populate the file
>> with the secrets in it.
> OK, so for a simple encrypted VM using root on luks, how in SNP does
> the boot loader obtain the disk passphrase?

The GHCB specification v2 provides a new VMGEXIT (GUEST_REQUEST) that be
used either by the guest BIOS or guest kernel to request the attestation
report from the SEV-SNP firmware at any time. In the case of SEV-SNP,
the boot loader need to talk to SEV-SNP firmware to get the attestation
report.

Once the attestation report is available then boot loader need to
connect to guest owner to validate and obtain the secret (i.e disk
decryption key).


> In the non SNP case, it's already upstream: OVMF finds the secret page
> and converts it to an EFI config table, which is passed into grub. 
> It's starting to sound like we'll need a new grub module for SNP which
> will do an active attestation and receive the passphrase over some
> channel secure against the cloud provider.  Could you give us an
> example of how you think this flow will work?

The flow will be like this:

1. During the guest creation, a hypervsior calls LAUNCH_UPDATE (type
secret) to tell PSP to populate a secret page at a fixed guest address. 
Note that secret page is slightly different compare to what we know from
the SEV and ES. In this case the secret page contains a key used for
protecting the communication channel between the PSP and guest.

2. OVMF will create a EFI configuration table with the location of
secrets page.

3. Boot loader (or any other EFI) app can locate the secret page through
the EFI config lookup.

4. Boot loader can use the key from the secret page to communicate with
the PSP and request for the attestation report.

5. Pass the attestation report to the guest owner.

6. The guest owner validates the attestation report and releases the key
directly to the guest.

7. Boot loader can use the secret to unlock or disk or do whatever it
needs with it.


> Thanks,
>
> James
>
>
