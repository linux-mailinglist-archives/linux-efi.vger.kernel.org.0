Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40AA47977B
	for <lists+linux-efi@lfdr.de>; Sat, 18 Dec 2021 00:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhLQXYv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Dec 2021 18:24:51 -0500
Received: from mail-dm6nam08on2040.outbound.protection.outlook.com ([40.107.102.40]:37280
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229512AbhLQXYv (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 17 Dec 2021 18:24:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GixPSYG+BYbgxTSiEubMeEkQJfSp8Mrul5ju5U22u/9f0PHaYziTSRaB4L3cCr01DKr7rchQgLtNaT38hfcQNdOcDE2BiVenNa65C3SZT05DulaLc0b83imJC53vY/tbuk+WCZEmg57jfZNwGaK4ULoUm1vnfAg5qq7TsvjK+1YkRs/AYI1M0WqqziRRaHlNpeBYoMgK+ShdcCDMD5GqJQVCsP7sMG1dKQf8pToCBZ2j0dHJnfkbZqtb4GNXNzNe/DvKCwZpABPQ5s1nETdXiZcRfhe2KcPboktmtu/rrtbiIXN2DATUxodGjQtIabTu8JEN+S7TmQIL71aaXKhGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeVZq4ejV2IqkXtuQk6VeFrxUsfAadaLkzgz8QN3yFU=;
 b=SWPjr7mLGzARxbYTjU+iwgTC/NqVldmZ2I+5mKniuLxuTkQEeJ7FiX3aaPDCLOe8/aPstoxPfL9h53giBRRyJxPJSJGnMea8K8TtBGAUKawYZ79uT30MaGAMqPx7sZyGq1qnTnZRBor9hgCNgb2fe1O8ovQP6IvJar6sJduJWhmCXFvHoaZYFeWWL0Hxt/JUXlAWpyHwSs8zC/2+taPaRWxHQOmsiLGwkYabM/nO18osZI1RW+wwldcm35hq6PR547J+2Ce+HMp8LOXjd2UT2O7HzHMTvMTp9ZYeGOtdzgLqbCv9l+YAQULUVGeX2CfcnqoU0cRDK/OI5cPuFZWaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeVZq4ejV2IqkXtuQk6VeFrxUsfAadaLkzgz8QN3yFU=;
 b=eIJy83T/aD1ufX0RQbmNh/JtYAlnLLilvpxEyBZMQV+Fo306wmYZOe4hw8QRxDKjn1fszPrCkyrYTxY1b/gvrtp7KlJIHkrXhGb+G3sMK2nLAzU0MyYh16UpVPDwzif+8GsvNQc5KvCjwpcliENga/SDjeJN7gJi9gimSe2Wx5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SN1PR12MB2541.namprd12.prod.outlook.com (2603:10b6:802:24::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 23:24:47 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35:281:b7f8:ed4c%6]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 23:24:47 +0000
Message-ID: <ac5a0aac-5a48-9136-2d5d-595cb99d2a6f@amd.com>
Date:   Fri, 17 Dec 2021 17:24:43 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 09/40] x86/compressed: Add helper for validating pages
 in the decompression stage
Content-Language: en-US
To:     Venu Busireddy <venu.busireddy@oracle.com>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-10-brijesh.singh@amd.com> <Ybz3XFbThJTUySNY@dt>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <Ybz3XFbThJTUySNY@dt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:806:122::15) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9ee1d66-5f68-4a29-7edd-08d9c1b46a00
X-MS-TrafficTypeDiagnostic: SN1PR12MB2541:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2541D9A451963E2ADBC3BF0CE5789@SN1PR12MB2541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CiOmWnBiGoci1VV41TS/zI+Mz6otZKT4JqjmrlNgBoUr26PoBEz6QFXz2KWA6s2mS4w3oqQsOfzMnWedSBM/SbJ9d610mtmoMDp5S9Jp/bkvOPE4Hua3QTJl5ztpd6eC4KCVZMG+SPZnSv82HnEHcw/s8s1DynxJN3rMVZvhyeNzMx+9PqwR6OO51KeggZfgdkFljDiYZcgZXetHJRwqBOwX8nDp9u831dTQgJ90LlxRHZe6WLIi9RZtuMqkhiIn6y+7V/uvrZaLkAwho333lkSo1ByFFpUu8Aqb/bDZBMMgcQt2SWco/TTHkkSRsJvg349p8p5mpxIgaoMfFQNvPVP/QTc5wFvF2xxoWLIVLihBMCEV2tvvlzvQZoacG4ec/mkSprAz4g9f41pHSpMJb+PTSu545/b8a5TlhGOC0n+h3ZjetHI3jImE1Z67lwBSIlTGVABHYyv+ybG6g85li74VdzhyWUkG6HvO4Dr9e2X9jb+rageJNcLQy3e394J1PG4ZcA5mC7FrK+WOr3RK33JM1bE7etRoGKtrcKJs5KSMcKhJMaMbDBLcIZfzukdeHaq6ksVJrLb6Ou8VKpAtXmYGxaZyTD9NkNMXhLTT1Can2n++lrh2ClH/IfThVegeKcvKytkYfCxKAUAUfOahusN5oduWH0tMwWU/sCSDQF9Ovca9pwezR/tpPAKKldxPzUntAHJnO57bJxLk4aXUxgPRCMaO3/uCF0IXi2g4VWf6gznhlAz8EZ9AyfigY16E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(38100700002)(316002)(53546011)(54906003)(4326008)(66946007)(7406005)(44832011)(66556008)(7416002)(8676002)(66476007)(83380400001)(6486002)(2906002)(6512007)(186003)(5660300002)(31686004)(6916009)(86362001)(26005)(8936002)(31696002)(6666004)(36756003)(2616005)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWtFbVptblVxNGZ1dVg1bzA1Z0hONW01YU56aTQ0RHg5QlFOZitrOFY2S1lM?=
 =?utf-8?B?RkZkZlFHTUMrNG1nMjlCT0VvNlpYbWxodFpJNmtYV0xETmh1RlhhYndQNjEw?=
 =?utf-8?B?Z1h3NTBURXpIQ3hObURtZDlrV3haM2dxNkQ0ZTF4VXZSaHUzR0gya2h6cDZ5?=
 =?utf-8?B?c2RQQWNleHU5V3pHM2RBZmpLbkZRQ3EzdWtGUUNDcW1wbzlIZmp3NjNrNm5D?=
 =?utf-8?B?ajZRSUo3WndXb1piaFJxTEtpdFUvaGRNTUtyNW8rYXJPZXkvTlFrVzQ0UGhl?=
 =?utf-8?B?U2M5ZndXYncxOUVUelpmWFNiNHJNYlM4bU9nVktEK210VTE2NFZZa0JyY2NE?=
 =?utf-8?B?VHlhSTY3dnFEZlZ6UkUrV3lMUnl6cGc1NElKQzcyMWxRTldaZTdLdXl4WkxE?=
 =?utf-8?B?dFhQd1dQbHlMUnVTdTZhdWZGSTZLN01rMTBpbjFEa05qMFpDNTN6UVdzdm1T?=
 =?utf-8?B?S1M2QTUwUmtnWkE5bk5ZcUNOUlZpMnpSNDhDeldmOXpPSFg1YUdOMTZQR1pn?=
 =?utf-8?B?N0JlNnJlU0xGdUtqaGVpSUVlSGFYYnFmVmdSZ0lMQmZjR0ZOM1VXdE5EWW1k?=
 =?utf-8?B?MzFBNnFwdkZqTFE4ZG5lQzFPSi9hRVdwZlRpa1JEOWJETjRXZ3ByLzBTTXNV?=
 =?utf-8?B?S0dFTFM0bWJKQ1VGZlg1L01kYzErcGVNNHVxaDJlQXRFZTZ1cUZ0dVpJZEFq?=
 =?utf-8?B?bjlFa2lXWlNBdWtBYmswcXNCMWsraG9sa0R6SVJDSHk4ZUozTUV0Z1VYK2tK?=
 =?utf-8?B?OUloUVVnQ3pHNHR6M0dxc3dFTHVCMWpKUGRVU2Z5MUV2OGxjdFFoZTdjeG1m?=
 =?utf-8?B?WmdOV3hsMG9VR3ROSGdsUGdrVnR1WUprN2RuN2hiU3Mwd3ZiNVNSOFlNZkto?=
 =?utf-8?B?Z2N2UGJPYThrUVZ5T2Y0QjVLVGd4U3dRMnVwcnNlN0FWOWxwV1FBcXp1cUpi?=
 =?utf-8?B?MW1tUWRtaXVjS2VUaEU0QUgzdGZ4N0ZwZTVsN1lFVzJEK0sxL2N0UEdCcDhw?=
 =?utf-8?B?VlhIVHF2Nm9PN3FYaGdFVDFXTE1kc3RUaHhFdStsb0tPYTcxelQrUlV3T3hY?=
 =?utf-8?B?OU0vZHE4eEp5L3ZPaFpvODYrR3ppdHBETUJjdndZWmhjaDBBOW00UDdIV0NF?=
 =?utf-8?B?Snk3VUdSdTZmRk40aSttZUlpMHJxUm9xeGlLODhadUU5YnBGckZ2S08xNVZL?=
 =?utf-8?B?eE9YcHhZTTdwdDRBZVhjT3c1YkZSTjFuNCtXc0tmZ2N5QUJjOU9obXMrcklO?=
 =?utf-8?B?UDA2N2ppMXdjVDgxOXNZRG5WYUp2MVQ0dEtJcSsweTE2aTkyMnVIaFZ5bGU2?=
 =?utf-8?B?UXppVnQ2SlJENmkzcXRhZHU1WkxWOVNaQlN5ejZ4WE5kMFZxakt4RGxGd0Fo?=
 =?utf-8?B?bGhLUWNjL3p4b3dRU3lORWNlbVlsU1o4RnNScnVNbVFxM1UwaS80dG9RSm5h?=
 =?utf-8?B?RnZhMjJPUlgxMi9DL0k1ODFaOHYzRVU2SE9jSFpWZVhpVTZubFFZTkRSc3NU?=
 =?utf-8?B?Tlg1RUE0eVFlS2QvY1dxQjJCbC9FOTk4T1RJV1NvQ0N3M05rV2RUQlB4aDli?=
 =?utf-8?B?ZUdCTlpyNHVqZEp6VWQxRHNCM0ttU1YrL1IrbXQ5TVRzY3BTV2lDTmFpWktQ?=
 =?utf-8?B?ZXJiR3VjcjRaLzcyV3BYRnVNSitvZHNUQnpVUllUa2NnM0VYa1VxdmpEbVhk?=
 =?utf-8?B?Q1hJaFNsMDlaYXBiTWFJVFBDTzBjS1pndjIySEYyb3BDZ1ZCWU80M0tIVnZu?=
 =?utf-8?B?OHRjenpwWHVaRkpoWHR4aVh2NkQrRktpTlM0ejFRUy9ndWRCTGczNVJtYmNj?=
 =?utf-8?B?dm9GTU5kZnlRa0JORlVXT0VqNC8wWkZaK2Mwc3ZDUmVUVTRIeThSVXhtOVNl?=
 =?utf-8?B?QUJ5TFZwcUNHZFNGQjYyMmpzZGRZTWZ1ZGtzdEhGZkxKa1BJdlpXMHliTmV5?=
 =?utf-8?B?b2gxaExiZzY3dlV5SjNPckx3L29DOEJFWTh4R0UrQTJ0ZzFDYldodE51dVpY?=
 =?utf-8?B?MGVjZTZ2MlZVd1hJcGNOZWMzV25lMG81OUYyakxpcW0ydWlzK3dScXllN1dJ?=
 =?utf-8?B?b3FLaTJvYVNEMGREa1YydmtwOWJiZUxjY1JscHRNYlVYUG1SbmpVY1NPOEZy?=
 =?utf-8?B?MGdPb0g3MjNZMHl0eXdwTEN4Vy9mK0k5SEdTRjAyZFFrdjBhZGMyUFdqSHhU?=
 =?utf-8?Q?OxUbBTRboNN6jeAYUmWn5Po=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ee1d66-5f68-4a29-7edd-08d9c1b46a00
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 23:24:47.1484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZbNKS5CJZZ2Q7DXeCU4HWJAjgFJZgEmoRGLMn32tQfNQxjyUnOP8TsAuBncoev4OXdzF8RzYVownB7tco5Viw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2541
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 12/17/21 2:47 PM, Venu Busireddy wrote:

>>  	 * the caches.
>>  	 */
>> -	if ((set | clr) & _PAGE_ENC)
>> +	if ((set | clr) & _PAGE_ENC) {
>>  		clflush_page(address);
>>  
>> +		/*
>> +		 * If the encryption attribute is being cleared, then change
>> +		 * the page state to shared in the RMP table.
>> +		 */
>> +		if (clr)
> This function is also called by set_page_non_present() with clr set to
> _PAGE_PRESENT. Do we want to change the page state to shared even when
> the page is not present? If not, shouldn't the check be (clr & _PAGE_ENC)?

I am not able to follow your comment. Here we only pay attention to the
encryption attribute, if encryption attribute is getting cleared then
make PSC. In the case ov set_page_non_present(), the outer if() block
will return false.  Am I missing something ?


>> +	/*
>> +	 * If private -> shared then invalidate the page before requesting the
> This comment is confusing. We don't know what the present state is,
> right? If we don't, shouldn't we just say:
>
>     If the operation is SNP_PAGE_STATE_SHARED, invalidate the page before
>     requesting the state change in the RMP table.
>
By default all the pages are private, so I don't see any issue with
saying "private -> shared".


>> +	 * state change in the RMP table.
>> +	 */
>> +	if (op == SNP_PAGE_STATE_SHARED && pvalidate(paddr, RMP_PG_SIZE_4K, 0))
>> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
>> +
>> +	/* Issue VMGEXIT to change the page state in RMP table. */
>> +	sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
>> +	VMGEXIT();
>> +
>> +	/* Read the response of the VMGEXIT. */
>> +	val = sev_es_rd_ghcb_msr();
>> +	if ((GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP) || GHCB_MSR_PSC_RESP_VAL(val))
>> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
>> +
>> +	/*
>> +	 * Now that page is added in the RMP table, validate it so that it is
>> +	 * consistent with the RMP entry.
> The page is not "added", right? Shouldn't we just say:

Technically, PSC modifies the RMP entry, so I should use that  instead
of calling "added".


>     Validate the page so that it is consistent with the RMP entry.

Yes, I am okay with it.


> Venu
