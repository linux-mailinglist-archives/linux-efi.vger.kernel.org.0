Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592C77054BC
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 19:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjEPRLB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 13:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjEPRKt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 13:10:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE8293C7;
        Tue, 16 May 2023 10:10:47 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GG4jkW030043;
        Tue, 16 May 2023 17:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PjwBvPQ9k1hjqiDjqcnqd4iWT/2euPsEqyqcVFWpXg8=;
 b=CMXoA8vbXZLga1CH3mCL7xL0RYECYajK+pBkeiizGF2WDHYzwV7sZgbq4ax5LQsZUCMm
 pY1YtxSAYGrnMZZZAGcqDmWPjThhy3rapuqdXMUy7UY7FSFh3bJsR+xP/EVdrrhUSim/
 51xiTid+sdYMxPBSgobk4YL3jdjqv6aRxp5K4geYoV8elWTcI7IvEhJ1Z5YRXfdxImqo
 oQrX2Ga4zAnY1YeLwpxnc55nvQQ1AJdYXqeEAoYSdcttBmmOcGYggQFA2FCSyUO+IY7e
 6njg+h408zFQKbMYuPOwZx2XckyMbiEPsYbzeKBrzH6LtZ0n9/b0nZecLMHTggv/jCVd UA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc3q40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 17:09:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GGvI6N033996;
        Tue, 16 May 2023 17:09:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104uej7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 17:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9voa+sKCy+NUIRhncHVeef6G+4Q5uXg6XgegbGdO1dpsZeRb33K5ABmWWn3o46/dKtW/FmSBp2oFbFd5bdjoCCkI+P1cjSeGlRhmCiENo2wJmjWMQzo8Fi9ACY1e9DnfLWwFT9Eb7SiU4m/13g+TY1MpedEnXZ+yu6rFh+p9TdPAcxpfR9C7/41NxPetG0UhbUEp3Zcb9c5xuDvMSgiAHzxwpnTLZTZSuPL4dPvPrwc0Ztl8HL3vC1fT03fxP6Rue2VTx6FB6xHDvzVXNuyvywQSLh9GFzksAizaSPPwoWtM9/5NY1K4QfJiqYXgMenSOHiKGk4KhU2pwtvzpiJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjwBvPQ9k1hjqiDjqcnqd4iWT/2euPsEqyqcVFWpXg8=;
 b=EsFlIiQv5O8iWrWgG9Y/63L7pg1QcUltT6Qi284grok77IFuSetl2o5UK4Sk/p2/T7aGg4lZYhKBMWZu7gdRzkPuR6GTvasn8xukOFe2jL0i7HWhD2sRlpIXPZKy9Whgg27Rfkdm+j4o0VSxQVo3aPZfUPtRU+02Y5M5Dsj4ISyeePU2RvBsLVXRMJlmCAbptewQ492MeATrxM06OiUKMVkHIf26dMipfHLNsYtuGnrqx8+Fo8Ut47mB9CSB58RQZxtCuaRK2FVdzJjfAUvAt+cRS+bqN1HwY9nC0erIgWboGH2szZvd4JKR6JqNfu3tc1dLTA59Zl+qIt4f2Ir50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjwBvPQ9k1hjqiDjqcnqd4iWT/2euPsEqyqcVFWpXg8=;
 b=dGGp5v9p1HSOuB80xFp4369H43I4eXuULfvPdQvd5A2kqu2l5zVuMGjEkLOCQNRZQzCMnV5IMIpR8ICriDXSANDcTs8ubvp+qdh5+vsO1oPD5Alm6UTV+VpK39PevRVr4QXx77K8gL1AweFo0IGHUa8o0CHjtTXC+/TfNSOc16E=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by CY5PR10MB5987.namprd10.prod.outlook.com (2603:10b6:930:29::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 17:09:32 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::8159:be9f:7968:8514]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::8159:be9f:7968:8514%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 17:09:32 +0000
Message-ID: <cf64d118-391c-dc40-5895-4f492b52ac7d@oracle.com>
Date:   Tue, 16 May 2023 18:09:18 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCHv11 4/9] x86/boot/compressed: Handle unaccepted memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230513220418.19357-1-kirill.shutemov@linux.intel.com>
 <20230513220418.19357-5-kirill.shutemov@linux.intel.com>
From:   Liam Merwick <liam.merwick@oracle.com>
In-Reply-To: <20230513220418.19357-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::18) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_|CY5PR10MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: e59f562e-c0c8-42d8-c89d-08db563050bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBPJ8XrfUe0dKGm7jK9f35V6kg4Q5Hcd8ITS+l248rMexMBUvqis2crvltYXw2tRP4psnNtzH9Y5mujw8pGTDxmLnYKIk1ViU7tYa9Ij7u/PgI/gbZtd05u8An+oN4H3r5s+u9PM9A2y2sHpH10dkpAFp0dydjsvIsfYq44xt7DY7yLC0ZlsmnaOpGGSS0yeXemQydB1V5M/UIPF+oRO87sKWaNBquc0fnrlNBiVfYRgZiMsW+8f9L84kZhSfd4guA9IuJ1sae6ozkSKTlm4tUcxIvoXJvPwharJoUjcQ5nh9amiq0vwuR1SHdn+++ksINYw/tk2cyIv1YICV4U2Id22322519ofu5It4KKaVLmSTcdD3D+sYpTyc8kaes8Wqft9UrshpD4EGLItlvweFLZnVgzTEvnnq9y+7mBJT4NheBLggtic9x4JZ24Q+jCQJ7a4orFSmoh+Fpchn/fMf4mD+/DHNuJFoy5rvhioU/MVYLJf5zSOA6gw3VBT6B/FJ8eiKJtx9wxzxt1UnqfCRgBrjRCygOQX3FYVrz3p5uEDDCwNNOrBpNVZwtDZpDFGVINRaieydWSarfqOnymg/6Mlsh4PMGq/aeovilp6hl16oyR6r6LhXXc4DBhBRvQu1u1QeWYY8tTJBaRi3CFWDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(31686004)(4326008)(66946007)(66476007)(66556008)(26005)(186003)(86362001)(6506007)(53546011)(31696002)(6512007)(6486002)(83380400001)(6666004)(2616005)(316002)(478600001)(36756003)(54906003)(110136005)(5660300002)(2906002)(38100700002)(41300700001)(8936002)(8676002)(7406005)(7416002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVZzdXBXWlhnbHA4K0YvSndtZ25tSnFScWRWUU9GWDFhSFF5V0tVS245MzA0?=
 =?utf-8?B?ekQrNEQ4d2c0YjNLeFVnakVnMVk5RjFGYWljaEt5MytvZk1aVHcwa0RSQzRx?=
 =?utf-8?B?Y0lwbktCWUx0UFd1aEYrUG4wNTdxckl3WkczNlNEdmtxeXBMamxUVmZ1UHhu?=
 =?utf-8?B?RDFOY3g1UlZEMk1zWjkzaE9ZL1VvV3FZRUcrUC9Sa25ZTHc0ZTRzSklUT1Ev?=
 =?utf-8?B?RmVsZU9nWUJIRFVVbEwza1Naa3VhNVQ0dE41YjlaK2EzT1BOLzRCTS9hYm5s?=
 =?utf-8?B?OVU1cmhEZWEyZmJ3dDMra1Y3dnRrOTJaaHhrNWlacUJmanF0a1IxUFNkSHJQ?=
 =?utf-8?B?Z3hzNEs1bU4vVWhUUGtsbEQ5R04vd2tiOWFIL0pSOU9qUytBVS93LzlScEN3?=
 =?utf-8?B?ZkErMmRqU09wczZLVHFzOW9uZnkxVDc1RE5CbkI0ZFZIa2lHa1IzZlRlUzEz?=
 =?utf-8?B?bHJVclhDTzRIb0hOVTRoM05ObWdaSThaUGlHYmlYYkx0RXBqTWJaTko2Tmpm?=
 =?utf-8?B?V1VBRHUvYVh6ckVQd3UwVnNsd210SWlNSENBV0JrLytBeG9vRTg4ellubVpK?=
 =?utf-8?B?OTVzLzd2MUZka1ZYTjB6M0p1K0g5UHlLZUtUSm5WaU9aNDZRYTJNODBTUVps?=
 =?utf-8?B?Mnk4RGsyTG9XK1FOWVRzZUdDU28xZkQvM2hxZnMzV2JvVVNXWkhqSXRIMkt5?=
 =?utf-8?B?UVVmaGpQSkxBWDQwaFQzK1NnK3JxUlc0bHF6ZTByaWxMUGprTVBvZWExOTRL?=
 =?utf-8?B?YW5EVys0MDhPWmVEckhMRUxRQjVRbi9EVEZtL3FjejlLdmpTL2lXOFh2VVdw?=
 =?utf-8?B?eGg3RHVERnpKWUg4OHdXQmI2Y2RzVHYwN29RdmRWNkJlN3BpdSthYWV3UDhi?=
 =?utf-8?B?Zm04MVFsSEhVZVF0dDZiZlB5SVBtUUYxNGQzT0h3M0pOTlZFYjhibUJYd3Zn?=
 =?utf-8?B?Y0hjeHR4Q3hxdzNiRGw1Wk1UaXpybzBUQ0U0TktoRGUycWREaGZoZzBPcEp6?=
 =?utf-8?B?K0ZkVFBWcW95OEF1OWV3NUdzRE9xV3laUld2ZUEwVGc5OEpmelhKclJpWU4w?=
 =?utf-8?B?L0gzTzlSTzZIR2U1K0F3eC9rMjJ2bGowTjBQNCtyOXgyWm05am85RUoxbUZQ?=
 =?utf-8?B?N3dXTWpOcXV3NTJMYk8xampIUUdjYXhLQ3laODJBWk81WUQ0Vjd1T0Z1Qmt2?=
 =?utf-8?B?c0xOSU5iSjV5RGJIZ1NtbWN6c0Fab2p2MG5xWHZqVURweTF0dkxONkdqOCts?=
 =?utf-8?B?L0Q5b09MRXY1dXJ2V21Ca0xzbzJIMmRwVG5uV1VVUkNFaCtzd0s4Y25aenZS?=
 =?utf-8?B?cVN2M2g3V3o1YmIvQjRqbmVYREg2VFAydGVhQWpRdVJWcnRsbXRRVm9HcG00?=
 =?utf-8?B?SUtxb1Rhc2l1Z21QbThndnhaNmZick9nS3FiNjJZcDZtNThza0xtL0RLRnBn?=
 =?utf-8?B?Y3V3ZzNjd1F6WlR0WnY1cW1idjdhTzJZOVVUdG5ObEpiTlNWZlo3V2hWQlk4?=
 =?utf-8?B?Smx1Z0FPRVJTVmJVQ2J6UC9VUXVUZ3h0UjA2cmJYY2pyR0ZIT0k2VmZVNFhX?=
 =?utf-8?B?TlBJM3IzQkVGNkVqeTFTVzJvWmttQU1sR3BNaFVmNGk2TVhFWEVsWnZ0enB5?=
 =?utf-8?B?dnpnekQ2bExVUVJCRXU2emMvRDF4S2l4eE5OaHRKU3grL1VMcE8xNzJXa1FF?=
 =?utf-8?B?QXN0NzVLblBGVWdwVEpDNnkvL3FSOFVTZTJzVEVFMGFTUkdoS1FvcWVHbHg4?=
 =?utf-8?B?TGhKMUZZamFyZFZ2RHdoTFJGSVhFWFVEcTZ6L3NLNGFsVWVZTFJ4VExuR2dx?=
 =?utf-8?B?WDdVejJIMlhVKzRnWElNSmVTMWNDV3F1UHg3K005SHBOUGJTbWF1NSt6N0lL?=
 =?utf-8?B?WW1kbVZyelAyMnhRMmpiVkR6NFh4ZW5rQmRiLzhieHFHeVdXTHZ5YnNHVWN3?=
 =?utf-8?B?UnRuUXZab2R4bnFSdURoTmdtamIwVlRERUJFTmRueGVvYzBDek9nR1UrTGdk?=
 =?utf-8?B?RHJUaURWNUEzR1VxZEJKVDRBNjNwMFo0d1cwbXdnS0RzeEd1bGVKYVZkcVFH?=
 =?utf-8?B?eEpJUDJMMXhjL0FJanozRm1CT2J2WnIzYXd1MUw5bkVlL09LYXJqQTJGV3Q5?=
 =?utf-8?Q?dnjn+cSSlE/ZofO+SYk7JBaU2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d21jSlBRSTgyU3YwUkRJOG1JWWNaYXRFU0RURnZGN2Z3cmtSWi93cGZzWWwy?=
 =?utf-8?B?ZDNXN2VQN0w1blFWY05XZmd5U1gwK01EakZPckgvY1RvbDFiK1dRUm04VzRK?=
 =?utf-8?B?aDR2MmR0dldQS3RteW5KeWh1VHFKQ3p2WmRQdGRReUQxZ1BIaUE3aURqZm1y?=
 =?utf-8?B?dVRHTjhxTGszVkhUZmFiRnNqT0NGc2tnb3JNcUwraTJRY1FwS1JxZTRvYUIr?=
 =?utf-8?B?L0dabkc5dUF4RHRuamIyb2x5dkVWdHJvMmRoS1BCWUxVb2k3bjc1TDVDZzJo?=
 =?utf-8?B?N3lCVVJiV0MrUmV4K3MyK05EazF0c2NaSjkwUjV6RjBQVUg0Wjd0a1NzNVN2?=
 =?utf-8?B?ayt5QkFJczFac2QwaXhZL0liT2haRFkwQ3dadEhWWTBRZXg2T3UrUDN3Z3Y4?=
 =?utf-8?B?NFhFZDluWnM1Wnl4V3VkKzhhZFIzcDJBNFRnTnpSUkJiT2hGTzYrSlQ2aDU4?=
 =?utf-8?B?bUx4UTVoUUZ6cnFhN2FrdmRwMFJzM0hFTkQwdnJwOThwSFBPclJHVjEyM2l1?=
 =?utf-8?B?K3JHM0t1VURzVDNjckV5TW9rUmZMT1dEWU9ZYW9YN0VSNGdCUzNBUU5weVp4?=
 =?utf-8?B?SUR5N2NsQjVlVkZQem94ZnljaHFLaWFFVE50eXRCRHZSTEpzbmlsd0FBNDZz?=
 =?utf-8?B?T0MrUEY2STVsUit0UFNqYTUxdFVwYUlsZUxPL3dDb3hmd2krS3h3VUY5d3JQ?=
 =?utf-8?B?Zk9zcE5TMHBDdlRMSDh3TVJpMnljc2Z1RW9ObFdDVjNhZjVTTUVhRWo5Y2xx?=
 =?utf-8?B?V0pKWENiQXdJcFd1bDJBU0syOXQ0WDUyK3h1STVjYmIxQzIvbGh0ZFhIMUZX?=
 =?utf-8?B?cFZrU2dWQW1PMzZsTlpqaUlZTk0xTGZObFR1VlJ2cTYxRXpZdktJTklNUlFl?=
 =?utf-8?B?aWRieEZEZEJuVTRid0tmcXU5N01TY1J5d2pzUTNVMFFTbm1YRFhzTTJKUEtz?=
 =?utf-8?B?MlVzZVhuZHE2RUVCODVPSitEOEZtYWo4dzhUeXh4MTFybnZFQmdsUEl5azdV?=
 =?utf-8?B?YmtoV2lydWxVQXAwc2tHNkpzUUVBalZzcXRwdm1VK0pPQzljVWlFMVU1aUpU?=
 =?utf-8?B?M3o4VGZXQzJSRFhhOVczK095NUlicldpMXhsWHlKbVI4RTNrTHJySVkxU1lF?=
 =?utf-8?B?UTdQUkYxTmVTUTRQQmR5djVHZ08yQ0FSVEJ5cENtMEptaGxTUnJtYnMxWkpK?=
 =?utf-8?B?di9icFVhOFd6UU1XbzFUUkVKRjU1TEY4bXBzNzZ1VzdLdGhIQTZ4ckdsOWpi?=
 =?utf-8?B?R09maTUzOFBNZDJXYkllVGRqNGxndmJyYkllcU1tekd0RHI3ckZTdDgzTCtQ?=
 =?utf-8?B?S2NsTGRHdkJOemFQQ3E0ektjN05MZk95SThEbWJFalR4RkI3cFllbW95V2hS?=
 =?utf-8?B?YjNjdFA0cVVXUjVHSDM4N0luZC9pWXNMYVBVTGhNeEVUc3lGZCtGVFNNMEF2?=
 =?utf-8?B?KzFLcGZ0dk9mRGl2clU3K2RhRXVqSjRoTzdhdjlPN1N5eDhYR1ZoK1NlV21o?=
 =?utf-8?B?anpqWWo1bHc1bW1CbzM5WHZYSTA5aE5nNmdob2F4a0Y2YjJFVXBaNDVacXU0?=
 =?utf-8?B?VlhYR0l6dStJajdTWGxvcUdMM0E0SytHcXFqb09zNzFoaDIwc0pDbG50QXRB?=
 =?utf-8?B?WVFpOEZNYlFBSHltaFMxNTNUSUhsL1BNajAveHN1SkVUUDhrTTV5ODlQc1VS?=
 =?utf-8?B?NWQ1MytyakxTakhvbkFtcTVyWlNBT2R0UjNMZUgremRTMDcvb1RkTVRIMFRm?=
 =?utf-8?Q?bCO3JAtmEMUy2SUpyRP0Pk9GS76e74Enn5vXtcq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59f562e-c0c8-42d8-c89d-08db563050bc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 17:09:32.1197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKQ3YOIgdq1qVl4F6JpqMKZh8FGGmtC5RvQYkxw8y88F2v+0x/Bn5PM6t4Er+yhwsQGrVm8izA1JOCVsvxG2MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5987
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_09,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160146
X-Proofpoint-ORIG-GUID: tZwK5Ih-KuCKVMh_-CPfvSSkN5T67xz0
X-Proofpoint-GUID: tZwK5Ih-KuCKVMh_-CPfvSSkN5T67xz0
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 13/05/2023 23:04, Kirill A. Shutemov wrote:
> The firmware will pre-accept the memory used to run the stub. But, the
> stub is responsible for accepting the memory into which it decompresses
> the main kernel. Accept memory just before decompression starts.
> 
> The stub is also responsible for choosing a physical address in which to
> place the decompressed kernel image. The KASLR mechanism will randomize
> this physical address. Since the unaccepted memory region is relatively


Reading this sentence, should "unaccepted" be "accepted" here?
(i.e. most memory at the start is unaccepted and the accepted region is 
the smaller one).

> small, KASLR would be quite ineffective if it only used the pre-accepted
> area (EFI_CONVENTIONAL_MEMORY). Ensure that KASLR randomizes among the
> entire physical address space by also including EFI_UNACCEPTED_MEMORY.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Otherwise

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


> ---
>   arch/x86/boot/compressed/efi.h   |  1 +
>   arch/x86/boot/compressed/kaslr.c | 35 +++++++++++++++++++++-----------
>   arch/x86/boot/compressed/misc.c  |  6 ++++++
>   arch/x86/boot/compressed/misc.h  |  6 ++++++
>   4 files changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
> index 7db2f41b54cd..cf475243b6d5 100644
> --- a/arch/x86/boot/compressed/efi.h
> +++ b/arch/x86/boot/compressed/efi.h
> @@ -32,6 +32,7 @@ typedef	struct {
>   } efi_table_hdr_t;
>   
>   #define EFI_CONVENTIONAL_MEMORY		 7
> +#define EFI_UNACCEPTED_MEMORY		15
>   
>   #define EFI_MEMORY_MORE_RELIABLE \
>   				((u64)0x0000000000010000ULL)	/* higher reliability */
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 454757fbdfe5..749f0fe7e446 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -672,6 +672,28 @@ static bool process_mem_region(struct mem_vector *region,
>   }
>   
>   #ifdef CONFIG_EFI
> +
> +/*
> + * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if supported) are
> + * guaranteed to be free.
> + *
> + * It is more conservative in picking free memory than the EFI spec allows:
> + *
> + * According to the spec, EFI_BOOT_SERVICES_{CODE|DATA} are also free memory
> + * and thus available to place the kernel image into, but in practice there's
> + * firmware where using that memory leads to crashes.
> + */
> +static inline bool memory_type_is_free(efi_memory_desc_t *md)
> +{
> +	if (md->type == EFI_CONVENTIONAL_MEMORY)
> +		return true;
> +
> +	if (md->type == EFI_UNACCEPTED_MEMORY)
> +		return IS_ENABLED(CONFIG_UNACCEPTED_MEMORY);
> +
> +	return false;
> +}
> +
>   /*
>    * Returns true if we processed the EFI memmap, which we prefer over the E820
>    * table if it is available.
> @@ -716,18 +738,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>   	for (i = 0; i < nr_desc; i++) {
>   		md = efi_early_memdesc_ptr(pmap, e->efi_memdesc_size, i);
>   
> -		/*
> -		 * Here we are more conservative in picking free memory than
> -		 * the EFI spec allows:
> -		 *
> -		 * According to the spec, EFI_BOOT_SERVICES_{CODE|DATA} are also
> -		 * free memory and thus available to place the kernel image into,
> -		 * but in practice there's firmware where using that memory leads
> -		 * to crashes.
> -		 *
> -		 * Only EFI_CONVENTIONAL_MEMORY is guaranteed to be free.
> -		 */
> -		if (md->type != EFI_CONVENTIONAL_MEMORY)
> +		if (!memory_type_is_free(md))
>   			continue;
>   
>   		if (efi_soft_reserve_enabled() &&
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index 014ff222bf4b..eb8df0d4ad51 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -455,6 +455,12 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
>   #endif
>   
>   	debug_putstr("\nDecompressing Linux... ");
> +
> +	if (IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
> +		debug_putstr("Accepting memory... ");
> +		accept_memory(__pa(output), __pa(output) + needed_size);
> +	}
> +
>   	__decompress(input_data, input_len, NULL, NULL, output, output_len,
>   			NULL, error);
>   	entry_offset = parse_elf(output);
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 2f155a0e3041..9663d1839f54 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -247,4 +247,10 @@ static inline unsigned long efi_find_vendor_table(struct boot_params *bp,
>   }
>   #endif /* CONFIG_EFI */
>   
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +void accept_memory(phys_addr_t start, phys_addr_t end);
> +#else
> +static inline void accept_memory(phys_addr_t start, phys_addr_t end) {}
> +#endif
> +
>   #endif /* BOOT_COMPRESSED_MISC_H */

