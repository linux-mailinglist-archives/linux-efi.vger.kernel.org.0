Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A517539FCD8
	for <lists+linux-efi@lfdr.de>; Tue,  8 Jun 2021 18:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhFHQxT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Jun 2021 12:53:19 -0400
Received: from mail-bn8nam12on2060.outbound.protection.outlook.com ([40.107.237.60]:17696
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232931AbhFHQxQ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 8 Jun 2021 12:53:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErnRPYHqZ+RPknkUcUXzARFm17mUIunsPMHeGq2b2TmgTPAKkzSzn4ncE1eJEh00Ygn91YmoZ285Hk10isHUzL6OIQ12ubKKR8mHide4F5IxEtq6dSllzAGbrfaD2DR37A3GAzFZTgYvhGnrYFHHWw4Y2bJr2NOgrB3MydoG28/ODlzAc/iRnX7d5gr3eX5p15ssPnzZ6mHn3MKZwuPWXmJMeYW4LMnS7RVKDRfFNxcmGrPJ4wB+MVG8qmWHnlnGtu8layZRZo2LL/9yGl3ea281fJ2bRf82bnnKoI5hPTBaPn3D8jqI6SaDEnkGZxz/8eZIUwfBHrH2rFTjGNFYNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7IDNK1jtqIzrXmy6vW4OPkdz+Fx/L68eLZTWTPen5E=;
 b=MoCtazqwzDHGbXauC/rfbilCqAp5Gw5aC8+CLNJooxhC+KQOMU+BN1E+xs2/9ofHLZptwA4uL505FYtooOl8elXKJtlsyF9JCxN2G8lWLLmJ9fsiyN3jY7hPkNzLC5GIdA62/Zxk4cXZJvxAEw5t/Bbm8K6/QTbWbZHUQ+K8Wu7mG+rHRqgkydTABPr8WVUn6rBtDT+8b9znuBeH+j88eJSE0EeMGSy00O2qCyirInAI4TLmEdLnUpiFFvsEHiWNWz/SbQPcIa8GKfhcDOSw5ODNj1bsg/jFbprWlBdH/j8LNfO8I1cdIrhkhYc/FsUs9j8Yq0BUzbOpawNB/BJJvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7IDNK1jtqIzrXmy6vW4OPkdz+Fx/L68eLZTWTPen5E=;
 b=IUpFW9A5z+KkaVYWI+xYGQSf2o+W6rFGm3klrHl3GZtlvMw1afCiFz1ham+nv0IgnRmKtpUigFmVXoy1CdlcUvX+KaJu15cZcoQ1L0qagCIIvi9NIi1VfV2uVbiR3GpqjLYVU4MHkA0YitPRrF9lLBdXfvmqAf2K/9NXbXQ3Omg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 16:51:21 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::a8a9:2aac:4fd1:88fa%3]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 16:51:21 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>, tony.luck@intel.com,
        npmccallum@redhat.com
Subject: Re: [PATCH Part1 RFC v3 02/22] x86/sev: Define the Linux specific
 guest termination reasons
To:     Venu Busireddy <venu.busireddy@oracle.com>
References: <20210602140416.23573-1-brijesh.singh@amd.com>
 <20210602140416.23573-3-brijesh.singh@amd.com> <YL+T7X/417sQAUUA@dt>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <919c9acc-2d83-be24-d0d3-4d54851ff049@amd.com>
Date:   Tue, 8 Jun 2021 11:51:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <YL+T7X/417sQAUUA@dt>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN7PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:806:127::10) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by SN7PR04CA0215.namprd04.prod.outlook.com (2603:10b6:806:127::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 8 Jun 2021 16:51:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18b81ab5-d6eb-4e3f-280e-08d92a9da4a2
X-MS-TrafficTypeDiagnostic: SA0PR12MB4509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4509BA865EC4D958A106410EE5379@SA0PR12MB4509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: weS0vFzZN4qDV15Vsyq5Co6G14Ux+eOnGVpbl3VGEsoRB2VJXQo6dItTZGUopdh3u4wtSwKK5Mr8bY7ZnpSbNbw/ueo2tCqTJrSx9jS88pDNifAxZai3NCMwzvq2CeOjiJJHTNFJJpo9I+QuiFAL/mSFjMzJ4TQg4oeyFH9k4T/9sGiM7w4Z4VDIxttOo0MAsSlTT+CmnjXX2oHwb3mqcz4bjhbWbg3vp9b2ZDhtPDk3ZpRd/VH9t2jOC1ZhUlclNTtlWxfV43u6/VxznMUoIvuAXbjCSPbcWjVLoFc5rACJxfEzcP/BjntNuePcdHDXfiselKQOlu2SvwT/CwG1G0syuGrUQHMzsvOE+b9E/8lsBlcLXExAC+nHcSnD0laRGpqiPyQAS5zqsGUI5gehUUHFsjnsb9+NP0teOTz+G/2H4Mj1QG97UexX2OqZmF2jFODI3RWHUF5aqkz1Rn+E8z8V1JkkDrmAPQfO9bR7Jg4whUfvXvbMaQZ0HxFkaAkWbM+vVA13iqDVdVPeVp3MyVAy2dp7VXi2GOYrKSRJyxtQRzFq1tnGZqFMFIfRpw+8hYuWrce10wnow8Nd5ro/Dw6sfhwUK3oDJwYIUaV2hc9b7REIZYTm44b9lOqzvMUpG9BBhUPqCpSnYlgKYLIgxfDv3/9fKrN2o4iW0m6p441NkxXozo8JL7JPGwzlKOXYdT57fT7dGySSaD/y0puQLRaSjO4B7L2o9AUl7LJm+mc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(83380400001)(31686004)(36756003)(5660300002)(6486002)(86362001)(8936002)(52116002)(53546011)(31696002)(6512007)(186003)(38350700002)(38100700002)(6916009)(2616005)(66556008)(66946007)(66476007)(44832011)(956004)(26005)(54906003)(7416002)(316002)(4744005)(2906002)(8676002)(16526019)(478600001)(6506007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmJUZ0owR2xCdWhmaTJRRE1XZlFKaThQak44bUlCMUZRU0l1Yy9rZ1RPSVBa?=
 =?utf-8?B?WVU0ZlFzYTR5OXB0TVJxQ1c4UDZzbXZ4NEdPTWZsR0VOb05wNGduU25UTFlw?=
 =?utf-8?B?T2NvUUs5U0lQeDFFTHlyMUtmZzlVZ0J4V1cxNWg0Wjg0YzVRWjdWT3ZrcEVL?=
 =?utf-8?B?M1pOcE4rbjJwVFlLMmVuOFlTaXFlUnoyNGVGaDlYYWlJcHhucWhRams2RWcw?=
 =?utf-8?B?WDRoSFBSVzBPNk9DZkdQV3JENVVuNE5LNnluZGo3Mm16UkVIdjJKZ3pldkRz?=
 =?utf-8?B?NGNaMmVRcVMyRG1hNkF4WXB3U3l0dllnbzRhZnRIeTcxbGZ5TEtlcnlENStH?=
 =?utf-8?B?MzAwWXVJa3JjS1Jla0x5bkdzRmZ4dDBCYjJxV2RvaGV5SGRqWE95M2pnT3k3?=
 =?utf-8?B?RjNYWVZVT2k2eWthVUdGekxNSUw2Zm5XbFpjM3FKakpPMWRWQ3JWNVhMU1FP?=
 =?utf-8?B?VFBCT3d6V0pYdGFVdDNlWGpIZHBzSWF1NERmQlFMQ3F3V0tsK2o1SGlvRE1O?=
 =?utf-8?B?SktFV1ppWWlhR1VIV3ZoSjhmU0tJQmdIQVFLOHErdDlZUWMrRCtreE5DSGth?=
 =?utf-8?B?Qm84eFRqY2JFanpNMzhEY2VUcmlnY1BMQ1pscEtlVk03WHJmYnpDUEFEK1Z1?=
 =?utf-8?B?VWp3RGpMZUJISTJQTGNiOXg3RXlyM3Nodk13VktXN1plLytrQWhSZGxyYXBk?=
 =?utf-8?B?L1dtR3liU3UvUy92Z1U3Ymh1dUxlbHMvU2twTEpCblBxeHpyRWZwOXhXSmNj?=
 =?utf-8?B?VzBmMzVxU0tNaGN3cURUclMyK2RPblBBRFNLTkYrOEtlMXdyeXBlUjlxVUJ5?=
 =?utf-8?B?N2VUeDZKaFR0eVpZT0JnOHBhNkFXbkFJSmRpaFEwY1VxNmo1VndnVEw3VkVn?=
 =?utf-8?B?aWsxNmxBR0VtdWtpRkcrTlZYSitwQ3lyNFU5UzBiMjFaZVREWTVJUm8wWHpV?=
 =?utf-8?B?V3JCdnhIRGp6S2EzQ3Vna2tQVnVleGZIRkpjaTR1Qk9xa05NZ3NqWXFsRnV4?=
 =?utf-8?B?amU4QWpKejFyYURQMEI4WHUxRnFHMTBINUR3dlIrV0xBYm15QVp0NDV0c0hw?=
 =?utf-8?B?RHVLbTJncFpCZE1BTDhBdHJ4Y0c4Z2RmU292SGt1MkhSLzV2YlNOa25jRWdu?=
 =?utf-8?B?cTN3UE1BMXpmSE5TS3R1UWJRbG1Hc1dZN0ZRa1hqZW84djVSRUhvK1ZMZW8w?=
 =?utf-8?B?a1pRRWpsUUJxUG5CWDhaUHgyL3MyWkNtdDNmQld1Q3FsNG9xUGE0eE5zdFl4?=
 =?utf-8?B?ZWFCVWsxR0hVTmN1UE1XaWh4Vm82cWtWaklKVTAxWmlXL3RvMmV6QzRNM0hO?=
 =?utf-8?B?aDcxdVIwN293VjFFVVVlclBGVXJqQkFWNVFONDlPMEx4M2FtbTZCcGNPaEN6?=
 =?utf-8?B?Y2JzalVHOGthWjlKQ3QxR3hVbWlxb2d3ekZGVXd0Y2p3MlkwYzA0VnFTeUov?=
 =?utf-8?B?RTliaTVkb1dGcmNxYmFjclNFSGMzK0FhM2NtVTlqWDk5bTMyZ0g1TStwcUZs?=
 =?utf-8?B?OFVxd0txdGRZSE1YQ29VS3piZCtKOHRVZGxEOHVvMzNqeDdOQk41RGRKYUxi?=
 =?utf-8?B?N0dVVC9pajBkZzA1SXF1aENNa3hkdmJlOTRlWFRGVDhxOXFYZDZhQ0hJemxK?=
 =?utf-8?B?NFJBVzl0Mjg1WjBSMFkwdFJ1aHhFN3R4c2N1WlhjbzN5enlDRGxUNjV1N2Z5?=
 =?utf-8?B?VHBTa2szeng2YnZJczZkWnh0VHcyazdiNWU3SnhvSjY0b2ViaEx3RFlmc0wy?=
 =?utf-8?Q?DlbzbMdnY+jlRSjEBq0q22Evayt4MgYfIhB0NSW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b81ab5-d6eb-4e3f-280e-08d92a9da4a2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 16:51:21.1777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjRC+Ila+V98iGETVvF/z7jjVuUhnlfc501NwELf2s6rEQGgmjMhZYM8302PNskanoVwmfEMjoiEMNtefDPXrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 6/8/21 10:59 AM, Venu Busireddy wrote:
>
>>  {
>>  	u64 val = GHCB_MSR_TERM_REQ;
>>  
>> @@ -32,7 +32,7 @@ static void __noreturn sev_es_terminate(unsigned int reason)
>>  	 * Tell the hypervisor what went wrong - only reason-set 0 is
>>  	 * currently supported.
>>  	 */
> Since reason set 0 is not the only set supported anymore, maybe the part
> about reason set 0 should be removed from the above comment?

Sure, I will update the comment. thanks


