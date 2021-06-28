Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7123B69C8
	for <lists+linux-efi@lfdr.de>; Mon, 28 Jun 2021 22:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhF1Umg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 28 Jun 2021 16:42:36 -0400
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:29470
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233593AbhF1Umf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 28 Jun 2021 16:42:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2zKuGcQaiq2tnVX5/ylbErITMzaslCSesJpeljkWEYGlBPb73bLe7EudqZhJPyUw3CdWmbK4WbI4xvA+MOMCQekX61Aatv+GzaAEUbBrvoFSly/rchA6ATAuNk/0B0wkMspppo4A3x+Cn5R2NtNLjTVa8TaTYvO2x8ZhXoh8851uFapMbnZqXLlungStcBAZAsxprcWFj+2xZ5ZG9A5i8YMkAA7Y2tgRtubOWoutETV3785SRlESTNPF2eHzaW1dy93VgYu3+rUP2GiGdFnHlj6RAR+xXYgZ/Ui5gOHpJ/dGWVvCZuK/xVZoPqqaAhngQCyTt4lwyeAk8gFvTY6kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj2LjUrGjCsrJcwTDwu9eLefXpbf7LtWn8VOoqwMj/o=;
 b=LxIhaEKxd8H6MDd2u1vGsP2IRbKjXfESPuEz28LCxKys1kgOgAOU1a5lEfcJ0W4yARRrDZqRbK0WmT6VN6yXErvKBOT0TVWzTntQNGu3Pu0qRCQJyPgZUpqWlVEyDF2RtWztmixrZvUzlw/RkHhycjZVkj86mLzumK29ktShlkuRbSKZLrud+NkLApuRoNA1+NWRFBVV/9VIYjaNK/o7Vd5ZaPwTVE5crH6GtLvyg1eLjbtf5u9eu310L3F4QPmgO26uXnUNG12tr4qJBruAEb/vqybdrtaZgjyAiJPtiUy5m1EMa2w/AN5hWvXBRJOx712slVvTrI7Bh1/eJyjeVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj2LjUrGjCsrJcwTDwu9eLefXpbf7LtWn8VOoqwMj/o=;
 b=tLNPoODM/K5DrUZc5CxKRBulJLdMIKjLJbaRcCN4DjaTRVeZoZS/Vw3yr3k75kZRKbGBI/H4c2Y5zyJ1szADC23ahXbyKT7yJw7MHyJ4EUfdgnsMlaySEOezOgJJRr+uJn0ury1YQ9iMDu/mgPjvhHBU4/H+mxk37wR6ofKNwH4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3465.namprd12.prod.outlook.com (2603:10b6:5:3a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.23; Mon, 28 Jun 2021 20:40:05 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::6437:2e87:f7dc:a686]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::6437:2e87:f7dc:a686%12]) with mapi id 15.20.4264.026; Mon, 28 Jun
 2021 20:40:04 +0000
Subject: Re: [RFC PATCH v2 2/3] efi: Reserve confidential computing secret
 area
To:     Dov Murik <dovmurik@linux.ibm.com>, linux-efi@vger.kernel.org
Cc:     Laszlo Ersek <lersek@redhat.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210628183431.953934-1-dovmurik@linux.ibm.com>
 <20210628183431.953934-3-dovmurik@linux.ibm.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <9b9b682f-297e-9ebd-4d67-43c3ed9ad8c5@amd.com>
Date:   Mon, 28 Jun 2021 15:40:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210628183431.953934-3-dovmurik@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN7PR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:806:121::6) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-ryzen.texastahm.com (67.79.209.213) by SN7PR04CA0061.namprd04.prod.outlook.com (2603:10b6:806:121::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Mon, 28 Jun 2021 20:40:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b52bcdf-0c44-4758-a08f-08d93a74e8c7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3465A4648E0A0A932D7C4D22EC039@DM6PR12MB3465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zOcnrJKFRAOXWQN9Xo28N6Xjy8bGED4QC36zFpG1PVDU3duM8kys5tQ14QwbU3Y05e6cLy1sr0gs/CUZ7mrR1vjwNRreOH96/9qJ1S5OCu1eVwIhVAqzmzaWsA/2H+CnagqzFDjJ67OZZPTdaXf/kMtHx8T9FIQadntdGZ7LmyRMM2QuIjVqUNctL8YYr2NJds9szUg2OSpn/vtkfSMnbjGk8TgdOGr89GY/K28Y5MbYhTyscOCbu6AieMJCcGUBcuLdb8sw3XwEbd2ugfhV8+WCkMwNElgYfyXCMd5DE3k4LhOY9Z/+eptMcQ/B18LRC/7bI266VyENzqlyQVCzoFjj1JlBfZneMgoO6c6U/y80VA4UiS7/KCARYkyTB9MonwVCptLWmz7FoWiql3lyDSFROClJCg6YDVqBHyrx16uGeSoMJ7nZdN5EzQlXh0JQAHK5eeYrxxa5s3U9Mvc1ZWkPB7lAzJ959SZNvgsfL/GlQll8jalX0Dkxo+ZLRMfgxfseW3z2SLbOUB+8M2VhR2F3jqDgGACzIzGmK0/xusXnPrvor6TvtXd+BmuWvUcCs8DfBlq246+TqEbUqYP5KlXic1QuHA61u3AiRP7Emzvx8FobZY8jPbonS+c7odqVH3ORANn8CuxIkS1ws3+aVH9cGhuep71MbyaZXtGkE+har07PgXfBOR1xaOlOQfAp5/xpJ6IMjQ2eVPoCJIa/Gr+MOGZRKrWw0rJb+PL63SaJCxK6/XbzSwb1HZdhKMMVL7xXkQuopqZc9pRAazNQrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(6506007)(53546011)(54906003)(6486002)(26005)(31686004)(16526019)(316002)(5660300002)(186003)(83380400001)(7416002)(86362001)(2906002)(2616005)(66946007)(31696002)(66556008)(66476007)(6512007)(4326008)(8676002)(956004)(478600001)(8936002)(36756003)(38100700002)(219293001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZldNUmkwMldINjRtZEtJZ0ExODFoQlYxdHUxaUROdG1wUExLOGx4RkRrRERh?=
 =?utf-8?B?YlplM0xCbkxsdGJWSEVVU0FHdGc0dDlkVTlVRXVSbkFhb0xtRmpMWXFmeUJ1?=
 =?utf-8?B?NHZnQ0hlckRmYTJmaS9PeEd2MVVjbXdUbzN3bG93MmI5WGVuNVN4L3NuVWJ1?=
 =?utf-8?B?SGsrOElHR3VDT3g2TVVtUTcyYWxJYnpDWDEvdHVmOFBIL0ovZHBUQmY4ckRI?=
 =?utf-8?B?NXNsQzVBejJuRDBZbFdNQ2VwcWhRRlppZ1ROTU1DbUlpZTkzZjkveGxBNlll?=
 =?utf-8?B?ZTVMaDhvamo1bWpPRjY5SW5wMjhGOVBVS2puUlBjTnh6UXAxMGpoSzZ6Tkln?=
 =?utf-8?B?MkVJaE9teG1ndEJCVWRxS2gwcWdJcHE5ZTZSU1praWFtWURmMjFTU2NkdDFB?=
 =?utf-8?B?RE9EdjJBeldRWTV2K3RHbEtmZEhuSEc5WUVPM2E5dlVnb05hY0xZY25kNFhh?=
 =?utf-8?B?QmdOTGVEMzYzZmd4ektUcE9BeU9mMkpydVFkNEU0SjlFN0dtZUgxcSsxVno1?=
 =?utf-8?B?YWRFWmNQMnpGQjBMUEM1MlM0aFhOQVZVdFpSenZFVG1OaXBrVjVJUG1HVTQx?=
 =?utf-8?B?N0JGd21TbmlFRDJnOGg3OE5kUDdKc1hYVldQajRtTUN6aElVYzByeVl4Wi9t?=
 =?utf-8?B?Sk1IRGV1aXNOckcrQjNBKzZlTmVCVFhUc2ZZamlST3lFb2tNdytwWGhhOThV?=
 =?utf-8?B?U0gyZ0RCSFJzNFdBeHYzU0g3OXJSa2wwQWVTbm1kcXcwMlBDTGk5VlNXWGdR?=
 =?utf-8?B?Nk1hdG85M2cvWWpxV3pZd21mVi9iTU5wVEtoUXpoZjJ2WENkczJGYVNtakxo?=
 =?utf-8?B?L1lYNzMyejZEVnlzM3dkdzBVQ1k2eVIrREI1VExmYWVHS3NVNGV2alp1UmJE?=
 =?utf-8?B?OXZXa09ibXRkLyszTmZQV1JJd2pqSFNzSitGbUJNL0xVR2NZTGd5bmx4VURD?=
 =?utf-8?B?eGN0Q0t4VEVLc2JtYldoL1pINi9mOWRhUU5qdVRaOWpnUmgyVTdaOHJRMHF6?=
 =?utf-8?B?WDh5bTZUeGhWeW5tNGNOWEpQdm1lRFJtclFIZldIai9jK1NOeFR0RWpxRU1t?=
 =?utf-8?B?Uml0MXZJelZ4TFBNRHQ5U2h5WnVDSTlVS0RzSnh4SWRmRFB4YkhKbzBVUnFx?=
 =?utf-8?B?UXgrMEl5WGRISXdudVJYU0RjdnZ2a0pvNkdHalBaalVNUUx6bzhFSnVmV2Ns?=
 =?utf-8?B?R3hDVGEvSUZHRDF1b3Znd0lSSE4ydVVLc01BaGIySkhuV2M5RkFxeTR6MDlt?=
 =?utf-8?B?MW1ZWStWVnBnUzhhQW9pOXFBZnVVQ2VxMGhMR215cXU1bEFIK3VSNFNxOFky?=
 =?utf-8?B?QTkrd2xMTm9WeDVtc043dXJEYVdwVHphL2VpK3A0bjNScEpxUXdtLzV2ODRK?=
 =?utf-8?B?RzJrSnpxN2pKUnJnL3p5aWxJYU9FRCtDMzk0MXpHTjNZVnRHd3ZDeUxaam5h?=
 =?utf-8?B?Qlo5cGV3U2tpL2RTQlBOVnBaU0hCR2NWRjNWZU91b25PZW4vYkk2Y3EraSti?=
 =?utf-8?B?ZmlBWXd0ZzhJOWJRNkRPeGJSUFhSL3diakFoamczaUt5enBOamZMeFgwVkl3?=
 =?utf-8?B?UC9LSlZXaDlEUnBLNndUVDdWLzdGQ0V2MUJKR3JNYVc3VHp4eSsvSVlxaU9p?=
 =?utf-8?B?NnQ2UEZ1aVU5S1U3QVZZWHdQcXVKODZCMzdnR0l2Q1paZ0tTTzE1R2xob0VL?=
 =?utf-8?B?dUxYemVuNUVVaUdGa1lHeHV2dEgvTmE3ZlZNeGRsVGNEMXQyTXJXakhlVUNK?=
 =?utf-8?Q?HaKNxh+9uoQp5Sg8yW5jyb00NfPBrZfk42esJnU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b52bcdf-0c44-4758-a08f-08d93a74e8c7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 20:40:04.8658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sF9mKDEfdYthohTGfYw3ixlr7/Yj0zLTXqTXDi3+SvMfaZORS9End4dLmP+aYSMZOK/vqUcDdc8SBD0c0lGW6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3465
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/28/21 1:34 PM, Dov Murik wrote:
> When efi-stub copies an EFI-provided confidential computing secret area,
> reserve that memory block for future use within the kernel.
> 
> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
> ---
>  drivers/firmware/efi/Makefile                 |  2 +-
>  drivers/firmware/efi/confidential-computing.c | 41 +++++++++++++++++++
>  drivers/firmware/efi/efi.c                    |  5 +++
>  include/linux/efi.h                           |  4 ++
>  4 files changed, 51 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/efi/confidential-computing.c
> 
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 4f647f1ee298..e9740bd16db0 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -551,6 +551,8 @@ extern struct efi {
>  	unsigned long			tpm_log;		/* TPM2 Event Log table */
>  	unsigned long			tpm_final_log;		/* TPM2 Final Events Log table */
>  	unsigned long			mokvar_table;		/* MOK variable config table */
> +	unsigned long			confidential_computing_secret;	/* Confidential computing */
> +									/* secret table           */

If there is any possibility that someone could reuse a form of this
confidential computing secret table in a bare metal system, then this
table needs to be added to the efi_tables[] array in
arch/x86/platform/efi/efi.c. Otherwise, it will be mapped improperly on a
system with SME active.

Thanks,
Tom

>  
>  	efi_get_time_t			*get_time;
>  	efi_set_time_t			*set_time;
> @@ -1190,6 +1192,8 @@ extern int efi_tpm_final_log_size;
>  
>  extern unsigned long rci2_table_phys;
>  
> +extern int efi_confidential_computing_secret_area_reserve(void);
> +
>  /*
>   * efi_runtime_service() function identifiers.
>   * "NONE" is used by efi_recover_from_page_fault() to check if the page
> 
