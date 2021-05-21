Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDF538CA7B
	for <lists+linux-efi@lfdr.de>; Fri, 21 May 2021 17:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbhEUP6X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 May 2021 11:58:23 -0400
Received: from mail-dm6nam11on2073.outbound.protection.outlook.com ([40.107.223.73]:3132
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234114AbhEUP6W (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 21 May 2021 11:58:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdxv9whOAwItJYy/8mTDbJzxqzslhInc4d+yr4dURXWDZE+Krwtqz8bKHNEFPukiglEj/PxG+PXsBHCzCpnGIY1EsbOA4Rhjd0Myb/HdFA2l3MjDlX34dSgXtSsyJ9tyXeGFA+1AcDf8TgoL+59+dY+joplAsrePLgUljtTvqjsexAwmHs1459WQlaHvXigcB+3Z7A46DANpW+D++ojfFoJD9fulLLQnFNbPIfdA8ufRgVYDiQs8Tch4WUS+LcdONz2EaBAQw6HIhtIlZd9wC7lKxaVpGggluBiZbLB+tu/IFZkoAY9JfdGkoz+6ztuNh8+G6ItSHXFEQbqtrNn42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pYpL2jonvVvlhT2mGQFCpym4q37MVLvZ+t53We4TSI=;
 b=c287DTZiwdoN5SAVlEnhl86caOh1bOoCcXVxzn4afqjW+vqHNalHLi4ajN1lh1mXnYH61ZVaRWGpwsebj+h9u1dtFuurrevcm5Kg4YCs7WypecjqHHXGz9NE3YF6cYWVbn9mx05gY0D4oiBBLiOnjlOOTVTYTBolY6fg7bbd3i7j/uylOYn6XjNOaT5dIynKFFYYKLT3repB7c1rdrwju0PvfuP0V3vrW6DqQ7DnV5x8gb8M/cNHpmCnclv/Q6yKGHgVloMLcmFCkteD+RBTJmTWGHotD+bdkN9BftvPciZzNYOFFT41Apd65ZA6E/UmuAKRuMLQGzpvbOVvIS42Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pYpL2jonvVvlhT2mGQFCpym4q37MVLvZ+t53We4TSI=;
 b=S1hcXAJClqxCO7+pJBcqT3g/z5OoMY0Yqsahr1uBUkZBBcmPY1sC24Xwb3Zonuz+Iyjz9smvTuT0PU2EoF6fnCQGbDDylVUffjg9rJNyaEQDMKRSQUq8g8On7SQjdrgp+48aeKkTAw2OkNDi55pkq7IYwZv7brQwfbRWAFkKnJA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:72::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 15:56:57 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::9898:5b48:a062:db94%6]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 15:56:57 +0000
Cc:     brijesh.singh@amd.com, Dov Murik <dovmurik@linux.ibm.com>,
        linux-efi@vger.kernel.org,
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
To:     Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20210513062634.2481118-1-dovmurik@linux.ibm.com>
 <2c8ae998-6dd0-bcb9-f735-e90da05ab9d9@amd.com> <YKZAUdbikp2Pt0XV@work-vm>
 <ccdf0059-7e39-7895-2733-412dbe4b13f1@linux.intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <c316c49c-03db-22e3-0072-ebaf3c7f2ca2@amd.com>
Date:   Fri, 21 May 2021 10:56:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
In-Reply-To: <ccdf0059-7e39-7895-2733-412dbe4b13f1@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SA9PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:20::14) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SA9PR03CA0009.namprd03.prod.outlook.com (2603:10b6:806:20::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 15:56:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7ac60e0-3867-454a-c305-08d91c710f94
X-MS-TrafficTypeDiagnostic: SN6PR12MB2686:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB268667502E07E4968932548CE5299@SN6PR12MB2686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1Zp6Wiyi8XLtNFjwNG7WZdyWYWg2tK20O52j7f6pbuM2ELkU6h1Kg1ExDjt13d38jHwJvqqycktLC2qPOalOUBsgk+OIesClENfRCdyMxeh7mbtac0zmCMbfK4lw5zFCc4vvHT/yAjVeNVYJnjV9XWRO6NIPuiv/O+lESr+l/HkEhb9/XDWWWRLEm/muERQjZaE8lO0hz81TIya7sP9ne7qrBTXWaXk0F7bSOVFUsXeNsUtk18Q2LVHOubj6P/V1bu24HCqn2qB4D2JzhqVTQePjuR2Wz1q62ym9unCjJqlPjEfsRMIY+uHXTOAspy38NHoWO3WqCm1ezC7+mWA4h41F4UKW0f16Av0kpYgglXqJATvZ5z+Qp/mXl4ZZd0DMJfGahCmhwaqWgvs/IlWr80zSed5Htj51sgMqBt0ag4+ypYMgD7q6aVm4ZYQYnvDOCy98EFs2U2TuyCFjyjo+Z7R+JejWrbA7KPrzqD0qyiY8tiANcS8rgAn+Gzjvf4mNMlVubGYok/4y5sa8wT1FSeDOyZir/nU/If8L7Ld6arU9a6bJ8Qa8cKV9YmvR2KUKXFOP/lM4I4kd2ski/J6AiV9hluE2egzYwkKThHTxyDALy2wFk2mIV9pPgkkj21rL95Xe2E+qYdSxcZG7nnBau9LKIh4elhp2Ok2SosVgLw8MtGmojeWUA/ZM2WLF0tNXIwer8LOUyTixWPcqeU7PN3pEvDOuHDUhJNk++ZFyRMBTm/RY3OQrNfXSVZvLVLN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39850400004)(366004)(110136005)(86362001)(54906003)(31696002)(26005)(478600001)(8676002)(4326008)(38350700002)(38100700002)(2906002)(7416002)(31686004)(44832011)(316002)(956004)(2616005)(6506007)(66556008)(83380400001)(66476007)(6512007)(66946007)(5660300002)(53546011)(16526019)(6486002)(52116002)(186003)(36756003)(8936002)(219293001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Zkppdjh2aWc2Mjlhem1PYnRjdzZZRDNjSkZJM0xIYUZaMUl0KzVCYWRKRTBV?=
 =?utf-8?B?d2REcE1uREZOYXI3NlZmOVp2K21mMXFOS3BrOWR4emI5ZXRqbjlIYUZBcFdT?=
 =?utf-8?B?c2x2UEUvUFVRSGRKKzFhZ0VPd2JUcHZpdmk3ZzhyNk8raFp4d25XN0NwdldZ?=
 =?utf-8?B?L0tpR255bkF2RkQyZTFXUHdaRTI0dTU3U1U4SHdKZ1h6Uko0U3k3UmZZTG80?=
 =?utf-8?B?emVoYXhWSFltNjkyN2xiWFdvNnlidlZhRlBHbmxTYzFwTXNIdjdobElKcURs?=
 =?utf-8?B?MmttUzJjZXJzaWpSTU1EamtPVnBhanlMaXFrdDUrK1pDTEpCYXExcFIzbVJC?=
 =?utf-8?B?REJQSWxiNS93V3ByTlhGMVRFczdSMFVBa0lxSUNmUEZqT0k0WnRNbEhJRklD?=
 =?utf-8?B?RU4zd3EyT00rSnkrQlU2OWwyUW1HOUVrcGQ2dUNGYVB2WG82UU0xODlHNWty?=
 =?utf-8?B?YzExQ1F4MUhyWXRjV0E0ZkJPaUowcjdNSTE4QlM2blhxRExWQ2l0MjhTSTht?=
 =?utf-8?B?Z2JmVm0yR3BnY0hhb1lFVGVPM3ZwOWR2RDNFNzFJM1ZsMTE0cHJaNDdpdlQx?=
 =?utf-8?B?ckd5dWwwWUxsZytQNjZLNVBkQTdtUTRtcnRLbnJNMDFLSEhkTHZCcytVK21w?=
 =?utf-8?B?c1ovcHFiL0tnbVBTVFhKWG9UeDVlMk1ESFZBM1FDRDROQ1p2dVdXTVhOU011?=
 =?utf-8?B?enRnL3JnNlhOV0VRZm1NOW4rNTRDV05LVW1YUVZKZTNia3BPOTlpY013a2pZ?=
 =?utf-8?B?MXZuQ1V1THlUUDFNajl2SXNsWnVJdG1TWktncTYyZ1pWbW9HandwMVBCQnNB?=
 =?utf-8?B?YUYvZ3hXMVNabG1nYzF0dHQvTVc0dE1zbnFZLysrekNMRlZERUovN1docFps?=
 =?utf-8?B?VVRZcEFzMGkwS0h4Q1IvM3pSZ2ZHdHFoaDlrbWhueUJpSVBpWmliRnZsVEEx?=
 =?utf-8?B?aUVDdmFSYUdKZUNWS1NrYmtSc1ZTVW10V2pGdUU1ZFlwY1BveU9PeUJWWDVz?=
 =?utf-8?B?MnA5UXViMWZTY3VMbTdKTnprTEVRZEtrV2hHYzZJdVB4bHQrMXVqdFhJK1li?=
 =?utf-8?B?clRWeU5lRkpNWFg3Uk94aUduYWkvNFVsZ1RuWUFyaVdGRzFKbDYwYW5JWlR3?=
 =?utf-8?B?b2EwUVFjbFFFWEFVYm5TdHpxWjBsaUlGcFZsNXF4c2R2SDBKdC9qN2MvSDRI?=
 =?utf-8?B?VThidlZXV2JDZUpobUZGRm5TYTdNRVZRcG80cDRNUEV2Q2duS20rZlh2c1ZK?=
 =?utf-8?B?NnkzaFRZS3hFd09sSmJ2WnhHQnVYSWlpblhnWDVhY0pKL2RmVjZlc29scVRL?=
 =?utf-8?B?Zmp4RDZlekFobmc3VGlhUk41U2tqcmkrQTY4WGZMdDlBeFNNcUhGUEdtY1R4?=
 =?utf-8?B?UEtvMWxXVEo5K01kMVBxSDZ6SEFHek1SQ2tiU3FIcktmay96d293eWpmZWw3?=
 =?utf-8?B?TkljcjlGUnRrVmdkNm9kUFpyOHdvLzQwT0M1S1J0WXlXQTR5Umc3cjJZbUpH?=
 =?utf-8?B?QkRXeGhPMUpRMDlqdHI2Z2xlSHFVUEtmTWN4WEFJQWU0QkVpblVlTkdkbTBH?=
 =?utf-8?B?c096L29pSEtJeVV4eEo2UlplZjFWLzNETkRveVVUeUdHVVNyZVdaREdMNDFJ?=
 =?utf-8?B?SWw1dWI0L1Z5eEtuRDMxbTRSWUlsSkVCQWp3QXRSVEV5UVpvREUzODJKNWM5?=
 =?utf-8?B?ZXVpa1AyT3BLc2h0SFIwT0EwSkdlZkhqWkt5V1k2SHVVcmUwc3JyNUdnM0V0?=
 =?utf-8?Q?vhgRYkT08Czsf5lc8qHNKrnQM9cIhHoxaYyTqFN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ac60e0-3867-454a-c305-08d91c710f94
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 15:56:57.1483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +D2Pkl8jC1eAZ3ZsgwmG6gZ1tYDUjv9a/aCa9VMrhYDZ9zdqsCS0E9IAnXVWKwTz4zy8kW49bCPjSBphO2aiug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 5/20/21 5:02 PM, Andi Kleen wrote:
>
> On 5/20/2021 3:56 AM, Dr. David Alan Gilbert wrote:
>> * Brijes
>> The nice thing about Dov's device/file is that it's a simple text file
>> that userspace can then read the secret out of;  I'm not sure if there's
>> anything similar in SNP (or for that matter TDX, cc'ing in Andi)
>
> In TDX there are two different mechanisms:
>
> - One is a ACPI table (SVKL) that allows to pass small pieces of data
> like keys from the BIOS. We have a little driver to read and clear the
> SVKL data. This would only be used if the TD BIOS does the negotiation
> for the secrets, which it doesn't do currently.
>
> - In the other model the negotiation is done by a user program, just
> using another driver to issue calls to the TDX module. The calls just
> expose the TDREPORT, which encodes the attestation data, but does not
> actually include any secret. Then the negotiation for the secrets is
> done by the program, which can then pass it out to other programs
> (like mount for encrypted file systems). In such a case the secret is
> never touched by the kernel. At least initially we'll use the second
> option.
>
The SEV-SNP attestation approach is very similar to what Andi described
for the TDX. However, in the case of legacy SEV and ES, the attestation
verification is performed before the guest is booted. In this case, the
hyervisor puts the secret provided by the guest owner (after the
attestation) at a fixed location. Dov's driver is simply reading that
fixed location and making it available through the simple text file.

In case of the SEV-SNP and TDX, the guest OS participates during the
attestation flow; the driver working on the behalf of userspace and does
not have access to the secret, so it cannot populate the file with the
secrets in it.

-Brijesh



> -Andi
>
> 57ccc1
