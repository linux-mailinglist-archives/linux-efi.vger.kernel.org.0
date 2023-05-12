Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C7B700C51
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 17:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241530AbjELPyO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 11:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241056AbjELPyG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 11:54:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00023C2F;
        Fri, 12 May 2023 08:54:04 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4SX9028695;
        Fri, 12 May 2023 15:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ywyQuK/Eq9ig+qqY8uJ465BXxN9GSGg0hCs+9HlmrTI=;
 b=ySbk5PNSxB50517NIbHO/oHeH0j2cobSiCPs2Udgt7VQwHPvUa1MWa906DXwVt0sD3DV
 CRn5k0sSw+WH0l+AIs66n9lmIw1EP1LlqwjXrTYVoPRIzHysGvq8rNkv4M9XaRkMNFCl
 SUe6vupmrE6oHKdP/yyCRd5r7AClssVrdaTBr7m5zKkP+oIZe7Cm/iN1lki+5k6C7F+l
 3KzJ42MtqtiC7Tml5UMw3LBatWdpaLBc1PLcYLQj2MfqAD4LM8IlZS5FBuSIWt5KK86P
 G906RokDsmDtWgDl37Cp2eEdF7HSd4TR0FxGWFORnNl8tLMmuDxBPFgZvVJdBTaINUrU +w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77dk149-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 15:53:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF0uwW030612;
        Fri, 12 May 2023 15:53:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf81js2pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 15:53:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5j00nueStLW2hc81we9AeWt18cjDno9cuGrHf+76xOGQjekV4nwlnaJEXB1TBb2KSy/UixytQx0Yh1IapmFscUX/aH0Kw8R5BMbnS9ihAi92zPxgofoL1ita3cagfK9pwdS6xbM4p+MmLAfKNoJwlX6JomMAkkDBqIyrN7AkVrWfOfHO46TKRZrmpnjhzPwziK6RyemPJffAMUfs2HN6EHQOiTUNLkHwkF9NtaVOY4fjAaBjAo9eF4FK9y6Z8AtIwYqEQ/fFhDNCMADtI8+nJXQlVDG8Cz83Hq0FLEgqjPmfXRlP/Pnsoolk4lfd46I78oWCRDsXvh90IPV7iiwWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywyQuK/Eq9ig+qqY8uJ465BXxN9GSGg0hCs+9HlmrTI=;
 b=kGHsVTHNAmlE1raBZpBXYh+IRYFEw+lvgNG2ijnDlbaPIScJIA/NqptrKpJXGQSKLPmOOVGOZA18ZL60GXVC8PPnt3wwN5bMPtNn/DIUMqSQ658YodWplzUZdzLSf2AZy7ZEIbXUOBulw4IyC2ZcvGxiXKnRWJCgXzv6SckzhG9qRkI4MybSintTLjYfyV/gH64lNF2ChfStrMXds27N0NkAP9hyE6WMOEy9E/wKCQU0iQ6+F3azpUV1LvzbyU7btjEK1v6uCf1ruZIeUqxnCKsJ+TUZzcKkqDBfAD3Any2RubCcGeego78hW0sudXjp2hSi2flu1Kt46lC+WzVn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywyQuK/Eq9ig+qqY8uJ465BXxN9GSGg0hCs+9HlmrTI=;
 b=XT7zxnyEfF/X1YgKHWcY2DKEODLNf7nsBV6fCgWISXsbywUqKgEEfQiV9zr61Bq0WtjI8srf+RltXjX4RNF90zvmhO7dckD0fB2fyJsHXXCKzeg2qojMtIDlATwuJfImrMBTzpsxfeL9NGemg4kLq9kVsFBaEkPOejYgovS/V5g=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DM4PR10MB6694.namprd10.prod.outlook.com (2603:10b6:8:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 15:53:13 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91%4]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 15:53:13 +0000
Message-ID: <6b36f194-660b-6fe8-ca38-aac467dacab2@oracle.com>
Date:   Fri, 12 May 2023 11:53:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 12/14] x86: Secure Launch late initcall platform module
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc:     dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com,
        Ross Philipson <ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-13-ross.philipson@oracle.com>
 <CSIYJAGZ8ZN0.2B2UF522LLEDR@suppilovahvero>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <CSIYJAGZ8ZN0.2B2UF522LLEDR@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:408:143::19) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|DM4PR10MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 9673b777-b996-4e36-3f7e-08db5300fdfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: halByJ31mwV+XSU3SnXC3lv6PeS8DeUOMhYpw9tHkoEX7tjt7koXf7LMxIUsAvn21naqaqAMhWYwKhnr7aThX7vaQGeYBNrpDpRwNvuVGiQmq6sjgK2C6c3hXQBJ0urL5If0UGaP/lld9WgWsxmeGhdALScjDR9cVyX9/3cOcGOKszoe3kfgxXgeXBeb76cEkIwRrIAss/oCpz4D+aPFeV6phaNHzuS0VLRp1Lst3rvmAqlI4pfnqtxvwUSPL9K3ZrB99d4uxExse6X74+WLo/PCQT3yOsY/O5bQ4K9FnVlSdvnLc063YA0zCUz6qixrp/EMqvudk7o6jS97cPrQDBgJr9fG6Xyz2qN5UO1zHoFG2/Qn0yvpc7YCf4uuF+Up4OsmBk4CHXfBTtNttHEji1H8CkJKkKlimqB7hiaHg6wKU0tLCE9LGU+CaXzEJSZE9DcI+0HRK7Eet3NNQSPxo+YOSNQia8CDrtG6oLyi6UN30dbewzHadksWVTS9u+ZhkAN7Ezf4xSNryVJ7zhscO+5piohopYwSwfjmFV8SzFWk3xKQb4cqxRKHVPLcJJbFvjU+V0cSg6jZBaXRZfmFd3I+hTOegRIlbc2ne3SVamBhaepIzOXYc/ChSufmrEQhxHnM9IRaMK8SQYCbPq5SPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(38100700002)(107886003)(8936002)(8676002)(31686004)(83380400001)(41300700001)(2616005)(66476007)(4326008)(66556008)(66946007)(316002)(7416002)(6506007)(6486002)(6512007)(36756003)(478600001)(186003)(53546011)(30864003)(31696002)(2906002)(86362001)(6666004)(44832011)(5660300002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGphVm5rcHNVZjN6SjZvRlh5TXdEYzNob2xFWURMZTdLbU16alloWE85UWZw?=
 =?utf-8?B?djFVSWZoWWhGU1JlTzM2Y3RodnU0bFR3a0pvZ1k3aE56Um94WEkxaUFXMmx3?=
 =?utf-8?B?SUNUdzhMam5MQzl1MzBYQkJ1Ry9Sc2EwaXlHOEQwVlgwd0RLQVcyeVNId3oz?=
 =?utf-8?B?emIzNGxiMmNmQkZvaXRacG5ENHZuMEx6VXozTTJFbm4rMGt0azdmV1lkNllp?=
 =?utf-8?B?MytxUjkvcXZXSlQrVmdIUTJ5MWs2c1F3NUFPdFZnc1M5Lzk1RmFDR3dqbTNL?=
 =?utf-8?B?b3BScElhKy9CTTRpZlpYOW1DMUl1WGV6aDZrUkw5TVFuaXlJNENDc0Y4Uytu?=
 =?utf-8?B?UmxCVU9vSVRXVkhhOXNxTXF1aTE0S21samxoV29NMXo4NHc1blVEaXo1NlRS?=
 =?utf-8?B?R2RpVkJzN3lzTmxuSFJLWHlBdmMwWkJwUG9Rd3hpMEJVS3R1NjZwUkNhd1N5?=
 =?utf-8?B?dkc4N2pSVTZBaXVFL2NqNDBJTndDNGEycVQ0Q2c3ZU4vNjNHK0FpN1p1S2Z3?=
 =?utf-8?B?eHYzdFp6ZURUcU1VcGU5cC9lUVNaMmZNV0M2SHlxMXo5cy9qYjFldmVrL2hC?=
 =?utf-8?B?VTZycHNnaXRNU1R4R1ZlNk5WZlpOOWRHQWZZZUlxcUZkODNldFVKbWtzRGNV?=
 =?utf-8?B?amxUcXhlYVZxUTNVNXdIRTBOL2dFdTZsa0o5V2xWVWFyWEdHaUZ0dUk0TXdR?=
 =?utf-8?B?dlJyYXU1c1VUQkFiZkptOG1VbnNBeUoyQXdubEVERU16VDFyNkU0MVR4elhq?=
 =?utf-8?B?aXVnRWhvRTJJT2lZZ3JYb3VzbXhZOXc2aHAzLzByVFN0VkZmZ3QvVlB4ZDFU?=
 =?utf-8?B?NDFOSkJvSWcwUTZqSklIeU5vdGIxdzFPSDFkcG5LOHZLNDFWSWYwUExKVkFR?=
 =?utf-8?B?N3k4VXhRZkJxRTc2RmFBVzdoaXJGcU45YlN1dkNZZ09VVHcwc0k1N3VVUnda?=
 =?utf-8?B?UldzcHJKVVp1MW9vMmhxZXUvZXFDbUNwMUJPdmIzR0RYbEtBMGJRR05KSS9l?=
 =?utf-8?B?WXhUTkVGaEpRZzNRQUJKRXRteUtZWXNvcWcwb2VROFRRYXhJL25IdEVwVERa?=
 =?utf-8?B?THo0eER2ZXROcjBaaUNPOUZxcDRhVC9haktGV1MxM29kVnlLd3Vnd0lxMmFk?=
 =?utf-8?B?K0FLbVViMW8zeElmNldaOWpIVmgrUGlFL0VzUEdxL09rYWRPemhodVI2Qys0?=
 =?utf-8?B?cUhUODNkWW0xUm9xSHF6TVNtUzZEV0ZxUVB6czd1c1hrSjMwcnhsTFl6WEhj?=
 =?utf-8?B?cGY1SDBMNEtmR0g3UVhUZm16N0lWbFRLd1BaUER3a1dSN2NGNExMd3JWRGpO?=
 =?utf-8?B?azNiaXlNaWVaamQza1gvNTNxajdub082RFoycWlEVkd5Mlh4N1N0clJ6eWtn?=
 =?utf-8?B?S1ROL2JMU0hwSnZuK29UVzR1bXMvTDlYS1FmT3ZzQ3BWSGxFMWpWMjNPMEU2?=
 =?utf-8?B?b1BaSUFOZGNIVWkxM3J6ekRFcjZBTFo0aExVZ3liNjZzODdJa085WXk4Zllk?=
 =?utf-8?B?anFDVVNkczliTVAwWXJKbkNjYmh5YlVzZVdyRjlZeXlJODdKMmxMeEZkMExv?=
 =?utf-8?B?OFNMR0cvYnNlYkJDelFZY21IVzhwaitxN3BvVVlsaTVuNmNaekJ2dm9jNXJv?=
 =?utf-8?B?SGpzdDUyUHRYVnB3Y0JtNnFNUGdQeGJCRkw0dXh4N3ZiR1VGYlVTZ29WMU4v?=
 =?utf-8?B?Qy9oT3JuSTFuNHBlQ0NBREhWVXQvV0dsV1JvN1RLcWk4RXlrQUpWMldJVnRy?=
 =?utf-8?B?aklGWmhQMExQUWxRYWo5Z0lkYnc5aUYyNWpQTzk0bUYremkzaGpQM3Z4RUJH?=
 =?utf-8?B?N09hNEZPZGlBbXgxblRtQ0lva1B0VmkxV01SNE5jd2h2MkJpNFBKcXhTdDhK?=
 =?utf-8?B?NHNNNjNwZ0x4ck14c1gzNXExZXYra0Vjei9Sa1hYMHVxVGZ2c3NVVnpyZWNn?=
 =?utf-8?B?RWRMNkp5SkVWSkxNQVRUbGhUeUxRc2lBQnE2aENMajFPSzNMaEZXVHpmOXFV?=
 =?utf-8?B?UldxaGhIYWlSR3FrQm9VRklQblhNSzBNRjVES2lqYWNWbjE4d3NJL0J1NEJ4?=
 =?utf-8?B?dWQ0UWJSTzdFRDFYSFlmbEk0ckYzY05iM2pGTGU3RmZ2Z2ZwOUpHVGhqTkNF?=
 =?utf-8?B?SWtyOVd3NllvQ2crbzlIdmJaeDZpb000a3pRaERaZW9wclhxNUhzakorbGlO?=
 =?utf-8?Q?1M440diWURzRRfRB4/CEpeI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VUh4QmNmSVJjTk1DTnR1dnRFWnJuMVpYREhNTExFSlh6U0tlZld3SlFhQnQy?=
 =?utf-8?B?aWdsMmhudUhEd2FDUGI1VUlQU1NGa1B1THE3NWZ1Y1Bkc1dUaXdJcWk2Njlt?=
 =?utf-8?B?VmMvYTFTUk16YXFwV05xWkF2Mk93WVEyMjY2YS9pVU9kSUV3dWlxMG1GQXdF?=
 =?utf-8?B?N0Yyc1I0UDNGWGE3MS9ZSU9vd243QnZ2aDR3VFBzVm1QMGtYZW1WNENoK0do?=
 =?utf-8?B?NFFLYnhJZ0JSaXcxL1RkbExrU1ZDK2NNMEVlZFg4cERRb2FPMTdoV3I3QVVH?=
 =?utf-8?B?K3ZDa2ZuWWxjU09yVTVuR25FZjVEYXV3QUJKdFBYM25TNEQyOUYzaUFYUlhu?=
 =?utf-8?B?YXJGSjN4Vy9meVU2YTZEY3NQTmNURDRra0dheDhzZE5Ha1AyQklTaUVpRWZq?=
 =?utf-8?B?QlBUemlzQzJNYnNjdk40OUFTNzhkcDdud0M3SzlMYmJOcHNyS1BrczRMbEhh?=
 =?utf-8?B?cjl2QmVFY21rTk1ZZUM4TlM4cXBaMHBydG1wNXJEdS9KWHBEaWQzbkV1RFpZ?=
 =?utf-8?B?QmlPNnpLcFZrQXpNOVdwRHFWQlVkQ1piNUZZa2E0a0xGTndOcGhJZWY2UlZq?=
 =?utf-8?B?L2U2MDBSeVVDUzE5Vk93MnlwUTQ3cVNjR016TUR5UWc5bUdGa3RJSVRMNkRO?=
 =?utf-8?B?enJtZlZJSWx2RkZhamxzVXJlRXhMWnYyMEhOKytBTVRmY0xIeHhpYzI4Rmxl?=
 =?utf-8?B?cHoya0VidGZKemFhd1ArTUw1UnZLQ3haQ2tHSldmYUFiRFRvcnpvK0Fqb1NO?=
 =?utf-8?B?RnJ1UzRzVlFTYTF5QkR6SUVTNEpEaFk5U3JzOFZRVVpGT1EzQjUrMGNaS2wz?=
 =?utf-8?B?RzNNVDEweXpxd2J0Y2hkSXh4QTBlY2Z6TVVycFlxKzNSTWM3cS8wRXptaVll?=
 =?utf-8?B?NDFGUE5CT2h3MTM0M3ZZOXh4eDF4SHdQRmxrU3dxUXVxTW9XbjQ1Q20vVWVR?=
 =?utf-8?B?WFZUaElwblV3ZnduZk9YQ3dzdThrSFFoTjBmUmd0T1AvZEFQY0F2Z1BmcGx6?=
 =?utf-8?B?d1JhNWtCWDAvb2lWMVJ4VTBBWGpzWVBxeEovTjFoVFFta25QZTJmRDdLazU4?=
 =?utf-8?B?V0w4WjJBbHM4UlI3WVFKZFIrRVE4RUtDUzdhY2JqOTJIM2E4R0ZPTEZTRmd3?=
 =?utf-8?B?bWZ2Zy9kME9BcE5EZWo2Q1ZON2FFWkNpVGNLMzBUdE1nbk9PM3dkTDNOZHNk?=
 =?utf-8?B?SEtSUnZFUEhqUUlKU0FNbDJJUjZZZjgrc2FMOERIZ28vL25VTi9LdHp1L0tu?=
 =?utf-8?B?ZU9NcDE5YytsSitVcFFFUXg1R1I0aDJNMTU1OGhCZXZEc1A0YXE2NFJlN2xJ?=
 =?utf-8?B?WE10bWZ2RExFdkh2Z09zY1hITnNseDE1THYxS01KYkxTVnZYSUdmcGQrcHlO?=
 =?utf-8?B?bk9PNitvNWxlR1NSSmU0Y3BTQXZsSXVySllxd2cwT3laMnNENndKSThRVWdE?=
 =?utf-8?B?UzNzbUtGSUJBYng1MFc1WDcvbm94OXpldTlNYUtPRXcrdXJRNmZaM3A4R1c0?=
 =?utf-8?B?ZUlCLy96NEt2cGhLWm9iN3B5QXlJN1RTaGF2OVlWZVhqK25ma2xmYmlpQ3E1?=
 =?utf-8?B?d2NvRjRVM0l0QlJYWEdQWjJzUldJNldWdmNtVWg0djdYMDFWRHBBTjFiQTc5?=
 =?utf-8?B?Q1VDWXBmRTdFSVhkc0FDRWpPVHZWUHd5RGNwN3ZDODBjc2RwYmRmOXNCYkVU?=
 =?utf-8?B?MEs0QTllRGYrMzE4K2xIQzJPMTNtM2Y3YXM4QVExS3k3ME8rd1dubUJRSHp1?=
 =?utf-8?Q?hc85u+DrwTmTE/HB6M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9673b777-b996-4e36-3f7e-08db5300fdfb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 15:53:13.1782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXM+sPLJvTBPwbQB2khEfI8mQHRuYKjarLWz+o0GOmR2TNwz5UHMGs6V3gAUSJuG/qbAnR0//JxuafzOQNI1YOmYKM5jHfnzyRh2xvjDnW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120132
X-Proofpoint-ORIG-GUID: SCeRWfcMMxJEb2Iq_fiFjAPFUdGXZuJN
X-Proofpoint-GUID: SCeRWfcMMxJEb2Iq_fiFjAPFUdGXZuJN
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/10/23 18:39, Jarkko Sakkinen wrote:
> On Thu May 4, 2023 at 5:50 PM EEST, Ross Philipson wrote:
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> The Secure Launch platform module is a late init module. During the
>> init call, the TPM event log is read and measurements taken in the
>> early boot stub code are located. These measurements are extended
>> into the TPM PCRs using the mainline TPM kernel driver.
>>
>> The platform module also registers the securityfs nodes to allow
>> access to TXT register fields on Intel along with the fetching of
>> and writing events to the late launch TPM log.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   arch/x86/kernel/Makefile   |   1 +
>>   arch/x86/kernel/slmodule.c | 520 +++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 521 insertions(+)
>>   create mode 100644 arch/x86/kernel/slmodule.c
>>
>> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
>> index 3d2a33e..ee3fe300 100644
>> --- a/arch/x86/kernel/Makefile
>> +++ b/arch/x86/kernel/Makefile
>> @@ -73,6 +73,7 @@ obj-$(CONFIG_IA32_EMULATION)	+= tls.o
>>   obj-y				+= step.o
>>   obj-$(CONFIG_INTEL_TXT)		+= tboot.o
>>   obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
>> +obj-$(CONFIG_SECURE_LAUNCH)	+= slmodule.o
>>   obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
>>   obj-y				+= stacktrace.o
>>   obj-y				+= cpu/
>> diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c
>> new file mode 100644
>> index 0000000..70dcff5
>> --- /dev/null
>> +++ b/arch/x86/kernel/slmodule.c
>> @@ -0,0 +1,520 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Secure Launch late validation/setup, securityfs exposure and
>> + * finalization support.
>> + *
>> + * Copyright (c) 2022 Apertus Solutions, LLC
>> + * Copyright (c) 2021 Assured Information Security, Inc.
>> + * Copyright (c) 2022, Oracle and/or its affiliates.
>> + *
>> + * Author(s):
>> + *     Daniel P. Smith <dpsmith@apertussolutions.com>
>> + *     Garnet T. Grimm <grimmg@ainfosec.com>
> 
> I'm not sure what the authors list is good for in the days of Git,
> and all the tags we have for commit messages.
> 
> Instead of this you could just put to the commit:
> 
> Co-developed-by: Garnet T. Grimm <grimmg@ainfosec.com>
> Signed-off-by: Garnet T. Grimm <grimmg@ainfosec.com>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> 
> See:
> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

Yes we will fix all that. And everything else you pointed out in this 
review.

Thanks

> 
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/fs.h>
>> +#include <linux/init.h>
>> +#include <linux/linkage.h>
>> +#include <linux/mm.h>
>> +#include <linux/io.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/security.h>
>> +#include <linux/memblock.h>
>> +#include <asm/segment.h>
>> +#include <asm/sections.h>
>> +#include <crypto/sha2.h>
>> +#include <linux/slr_table.h>
>> +#include <linux/slaunch.h>
>> +
>> +#define DECLARE_TXT_PUB_READ_U(size, fmt, msg_size)			\
>> +static ssize_t txt_pub_read_u##size(unsigned int offset,		\
>> +		loff_t *read_offset,					\
>> +		size_t read_len,					\
>> +		char __user *buf)					\
> 
> This would really deserve:
> 
> /*
>   * Explain what DECLARE_TXT_PUB_READ_U is.
>   */
> 
>> +{									\
>> +	void __iomem *txt;						\
>> +	char msg_buffer[msg_size];					\
> 
> Reverse-christmas tree order.
> 
>> +	u##size reg_value = 0;						\
>> +	txt = ioremap(TXT_PUB_CONFIG_REGS_BASE,				\
>> +			TXT_NR_CONFIG_PAGES * PAGE_SIZE);		\
>> +	if (!txt)						\
>> +		return -EFAULT;					\
>> +	memcpy_fromio(&reg_value, txt + offset, sizeof(u##size));	\
>> +	iounmap(txt);							\
>> +	snprintf(msg_buffer, msg_size, fmt, reg_value);			\
>> +	return simple_read_from_buffer(buf, read_len, read_offset,	\
>> +			&msg_buffer, msg_size);				\
>> +}
>> +
>> +DECLARE_TXT_PUB_READ_U(8, "%#04x\n", 6);
>> +DECLARE_TXT_PUB_READ_U(32, "%#010x\n", 12);
>> +DECLARE_TXT_PUB_READ_U(64, "%#018llx\n", 20);
>> +
>> +#define DECLARE_TXT_FOPS(reg_name, reg_offset, reg_size)		\
>> +static ssize_t txt_##reg_name##_read(struct file *flip,			\
>> +		char __user *buf, size_t read_len, loff_t *read_offset)	\
>> +{									\
>> +	return txt_pub_read_u##reg_size(reg_offset, read_offset,	\
>> +			read_len, buf);					\
>> +}									\
>> +static const struct file_operations reg_name##_ops = {			\
>> +	.read = txt_##reg_name##_read,					\
>> +}
>> +
>> +DECLARE_TXT_FOPS(sts, TXT_CR_STS, 64);
>> +DECLARE_TXT_FOPS(ests, TXT_CR_ESTS, 8);
>> +DECLARE_TXT_FOPS(errorcode, TXT_CR_ERRORCODE, 32);
>> +DECLARE_TXT_FOPS(didvid, TXT_CR_DIDVID, 64);
>> +DECLARE_TXT_FOPS(e2sts, TXT_CR_E2STS, 64);
>> +DECLARE_TXT_FOPS(ver_emif, TXT_CR_VER_EMIF, 32);
>> +DECLARE_TXT_FOPS(scratchpad, TXT_CR_SCRATCHPAD, 64);
>> +
>> +/*
>> + * Securityfs exposure
>> + */
>> +struct memfile {
>> +	char *name;
>> +	void *addr;
>> +	size_t size;
>> +};
>> +
>> +static struct memfile sl_evtlog = {"eventlog", 0, 0};
>> +static void *txt_heap;
>> +static struct txt_heap_event_log_pointer2_1_element __iomem *evtlog20;
>> +static DEFINE_MUTEX(sl_evt_log_mutex);
>> +
>> +static ssize_t sl_evtlog_read(struct file *file, char __user *buf,
>> +			      size_t count, loff_t *pos)
>> +{
>> +	ssize_t size;
>> +
>> +	if (!sl_evtlog.addr)
>> +		return 0;
>> +
>> +	mutex_lock(&sl_evt_log_mutex);
>> +	size = simple_read_from_buffer(buf, count, pos, sl_evtlog.addr,
>> +				       sl_evtlog.size);
>> +	mutex_unlock(&sl_evt_log_mutex);
>> +
>> +	return size;
>> +}
>> +
>> +static ssize_t sl_evtlog_write(struct file *file, const char __user *buf,
>> +				size_t datalen, loff_t *ppos)
>> +{
>> +	ssize_t result;
>> +	char *data;
>> +
>> +	if (!sl_evtlog.addr)
>> +		return 0;
>> +
>> +	/* No partial writes. */
>> +	result = -EINVAL;
>> +	if (*ppos != 0)
>> +		goto out;
>> +
>> +	data = memdup_user(buf, datalen);
>> +	if (IS_ERR(data)) {
>> +		result = PTR_ERR(data);
>> +		goto out;
>> +	}
>> +
>> +	mutex_lock(&sl_evt_log_mutex);
>> +	if (evtlog20)
>> +		result = tpm20_log_event(evtlog20, sl_evtlog.addr,
>> +					 sl_evtlog.size, datalen, data);
>> +	else
>> +		result = tpm12_log_event(sl_evtlog.addr, sl_evtlog.size,
>> +					 datalen, data);
>> +	mutex_unlock(&sl_evt_log_mutex);
>> +
>> +	kfree(data);
>> +out:
>> +	return result;
>> +}
>> +
>> +static const struct file_operations sl_evtlog_ops = {
>> +	.read = sl_evtlog_read,
>> +	.write = sl_evtlog_write,
>> +	.llseek	= default_llseek,
>> +};
>> +
>> +struct sfs_file {
>> +	const char *name;
>> +	const struct file_operations *fops;
>> +};
>> +
>> +#define SL_TXT_ENTRY_COUNT	7
>> +static const struct sfs_file sl_txt_files[] = {
>> +	{ "sts", &sts_ops },
>> +	{ "ests", &ests_ops },
>> +	{ "errorcode", &errorcode_ops },
>> +	{ "didvid", &didvid_ops },
>> +	{ "ver_emif", &ver_emif_ops },
>> +	{ "scratchpad", &scratchpad_ops },
>> +	{ "e2sts", &e2sts_ops }
>> +};
>> +
>> +/* sysfs file handles */
>> +static struct dentry *slaunch_dir;
>> +static struct dentry *event_file;
>> +static struct dentry *txt_dir;
>> +static struct dentry *txt_entries[SL_TXT_ENTRY_COUNT];
>> +
>> +static long slaunch_expose_securityfs(void)
>> +{
>> +	long ret = 0;
>> +	int i;
>> +
>> +	slaunch_dir = securityfs_create_dir("slaunch", NULL);
>> +	if (IS_ERR(slaunch_dir))
>> +		return PTR_ERR(slaunch_dir);
>> +
>> +	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
>> +		txt_dir = securityfs_create_dir("txt", slaunch_dir);
>> +		if (IS_ERR(txt_dir)) {
>> +			ret = PTR_ERR(txt_dir);
>> +			goto remove_slaunch;
>> +		}
>> +
>> +		for (i = 0; i < ARRAY_SIZE(sl_txt_files); i++) {
>> +			txt_entries[i] = securityfs_create_file(
>> +						sl_txt_files[i].name, 0440,
>> +						txt_dir, NULL,
>> +						sl_txt_files[i].fops);
>> +			if (IS_ERR(txt_entries[i])) {
>> +				ret = PTR_ERR(txt_entries[i]);
>> +				goto remove_files;
>> +			}
>> +		}
>> +
>> +	}
>> +
>> +	if (sl_evtlog.addr > 0) {
>> +		event_file = securityfs_create_file(
>> +					sl_evtlog.name, 0440,
>> +					slaunch_dir, NULL,
>> +					&sl_evtlog_ops);
>> +		if (IS_ERR(event_file)) {
>> +			ret = PTR_ERR(event_file);
>> +			goto remove_files;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +
>> +remove_files:
>> +	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
>> +		while (--i >= 0)
>> +			securityfs_remove(txt_entries[i]);
>> +		securityfs_remove(txt_dir);
>> +	}
>> +remove_slaunch:
>> +	securityfs_remove(slaunch_dir);
>> +
>> +	return ret;
>> +}
>> +
>> +static void slaunch_teardown_securityfs(void)
>> +{
>> +	int i;
>> +
>> +	securityfs_remove(event_file);
>> +	if (sl_evtlog.addr) {
>> +		memunmap(sl_evtlog.addr);
>> +		sl_evtlog.addr = NULL;
>> +	}
>> +	sl_evtlog.size = 0;
>> +
>> +	if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
>> +		for (i = 0; i < ARRAY_SIZE(sl_txt_files); i++)
>> +			securityfs_remove(txt_entries[i]);
>> +
>> +		securityfs_remove(txt_dir);
>> +
>> +		if (txt_heap) {
>> +			memunmap(txt_heap);
>> +			txt_heap = NULL;
>> +		}
>> +	}
>> +
>> +	securityfs_remove(slaunch_dir);
>> +}
>> +
>> +static void slaunch_intel_evtlog(void __iomem *txt)
>> +{
>> +	struct slr_entry_log_info *log_info;
>> +	struct txt_os_mle_data *params;
>> +	struct slr_table *slrt;
>> +	void *os_sinit_data;
>> +	u64 base, size;
>> +
>> +	memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(base));
>> +	memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(size));
>> +
>> +	/* now map TXT heap */
>> +	txt_heap = memremap(base, size, MEMREMAP_WB);
>> +	if (!txt_heap)
>> +		slaunch_txt_reset(txt,
>> +			"Error failed to memremap TXT heap\n",
>> +			SL_ERROR_HEAP_MAP);
>> +
>> +	params = (struct txt_os_mle_data *)txt_os_mle_data_start(txt_heap);
>> +
>> +	/* Get the SLRT and remap it */
>> +	slrt = memremap(params->slrt, sizeof(*slrt), MEMREMAP_WB);
>> +	if (!slrt)
>> +		slaunch_txt_reset(txt,
>> +			"Error failed to memremap SLR Table\n",
>> +			SL_ERROR_SLRT_MAP);
>> +	size = slrt->size;
>> +	memunmap(slrt);
>> +
>> +	slrt = memremap(params->slrt, size, MEMREMAP_WB);
>> +	if (!slrt)
>> +		slaunch_txt_reset(txt,
>> +			"Error failed to memremap SLR Table\n",
>> +			SL_ERROR_SLRT_MAP);
>> +
>> +	log_info = (struct slr_entry_log_info *)
>> +			slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
>> +	if (!log_info)
>> +		slaunch_txt_reset(txt,
>> +			"Error failed to memremap SLR Table\n",
>> +			SL_ERROR_SLRT_MISSING_ENTRY);
>> +
>> +	sl_evtlog.size = log_info->size;
>> +	sl_evtlog.addr = memremap(log_info->addr, log_info->size,
>> +				  MEMREMAP_WB);
>> +	if (!sl_evtlog.addr)
>> +		slaunch_txt_reset(txt,
>> +			"Error failed to memremap TPM event log\n",
>> +			SL_ERROR_EVENTLOG_MAP);
>> +
>> +	memunmap(slrt);
>> +
>> +	/* Determine if this is TPM 1.2 or 2.0 event log */
>> +	if (memcmp(sl_evtlog.addr + sizeof(struct tcg_pcr_event),
>> +		    TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
>> +		return; /* looks like it is not 2.0 */
>> +
>> +	/* For TPM 2.0 logs, the extended heap element must be located */
>> +	os_sinit_data = txt_os_sinit_data_start(txt_heap);
>> +
>> +	evtlog20 = tpm20_find_log2_1_element(os_sinit_data);
>> +
>> +	/*
>> +	 * If this fails, things are in really bad shape. Any attempt to write
>> +	 * events to the log will fail.
>> +	 */
>> +	if (!evtlog20)
>> +		slaunch_txt_reset(txt,
>> +			"Error failed to find TPM20 event log element\n",
>> +			SL_ERROR_TPM_INVALID_LOG20);
>> +}
>> +
>> +static void slaunch_tpm20_extend_event(struct tpm_chip *tpm, void __iomem *txt,
>> +				       struct tcg_pcr_event2_head *event)
>> +{
>> +	u16 *alg_id_field = (u16 *)((u8 *)event +
>> +				    sizeof(struct tcg_pcr_event2_head));
>> +	struct tpm_digest *digests;
>> +	u8 *dptr;
>> +	int ret;
>> +	u32 i, j;
>> +
>> +	digests = kcalloc(tpm->nr_allocated_banks, sizeof(*digests),
>> +			  GFP_KERNEL);
>> +	if (!digests)
>> +		slaunch_txt_reset(txt,
>> +			"Failed to allocate array of digests\n",
>> +			SL_ERROR_GENERIC);
>> +
>> +	for (i = 0; i < tpm->nr_allocated_banks; i++)
>> +		digests[i].alg_id = tpm->allocated_banks[i].alg_id;
>> +
>> +
>> +	/* Early SL code ensured there was a max count of 2 digests */
>> +	for (i = 0; i < event->count; i++) {
>> +		dptr = (u8 *)alg_id_field + sizeof(u16);
>> +
>> +		for (j = 0; j < tpm->nr_allocated_banks; j++) {
>> +			if (digests[j].alg_id != *alg_id_field)
>> +				continue;
>> +
>> +			switch (digests[j].alg_id) {
>> +			case TPM_ALG_SHA256:
>> +				memcpy(&digests[j].digest[0], dptr,
>> +				       SHA256_DIGEST_SIZE);
>> +				alg_id_field = (u16 *)((u8 *)alg_id_field +
>> +					SHA256_DIGEST_SIZE + sizeof(u16));
>> +				break;
>> +			case TPM_ALG_SHA1:
>> +				memcpy(&digests[j].digest[0], dptr,
>> +				       SHA1_DIGEST_SIZE);
>> +				alg_id_field = (u16 *)((u8 *)alg_id_field +
>> +					SHA1_DIGEST_SIZE + sizeof(u16));
>> +			default:
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
>> +	ret = tpm_pcr_extend(tpm, event->pcr_idx, digests);
>> +	if (ret) {
>> +		pr_err("Error extending TPM20 PCR, result: %d\n", ret);
>> +		slaunch_txt_reset(txt,
>> +			"Failed to extend TPM20 PCR\n",
>> +			SL_ERROR_TPM_EXTEND);
>> +	}
>> +
>> +	kfree(digests);
>> +}
>> +
>> +static void slaunch_tpm20_extend(struct tpm_chip *tpm, void __iomem *txt)
>> +{
>> +	struct tcg_pcr_event *event_header;
>> +	struct tcg_pcr_event2_head *event;
>> +	int start = 0, end = 0, size;
>> +
>> +	event_header = (struct tcg_pcr_event *)(sl_evtlog.addr +
>> +						evtlog20->first_record_offset);
>> +
>> +	/* Skip first TPM 1.2 event to get to first TPM 2.0 event */
>> +	event = (struct tcg_pcr_event2_head *)((u8 *)event_header +
>> +						sizeof(struct tcg_pcr_event) +
>> +						event_header->event_size);
>> +
>> +	while ((void  *)event < sl_evtlog.addr + evtlog20->next_record_offset) {
>> +		size = __calc_tpm2_event_size(event, event_header, false);
>> +		if (!size)
>> +			slaunch_txt_reset(txt,
>> +				"TPM20 invalid event in event log\n",
>> +				SL_ERROR_TPM_INVALID_EVENT);
>> +
>> +		/*
>> +		 * Marker events indicate where the Secure Launch early stub
>> +		 * started and ended adding post launch events.
>> +		 */
>> +		if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
>> +			end = 1;
>> +			break;
>> +		} else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
>> +			start = 1;
>> +			goto next;
>> +		}
>> +
>> +		if (start)
>> +			slaunch_tpm20_extend_event(tpm, txt, event);
>> +
>> +next:
>> +		event = (struct tcg_pcr_event2_head *)((u8 *)event + size);
>> +	}
>> +
>> +	if (!start || !end)
>> +		slaunch_txt_reset(txt,
>> +			"Missing start or end events for extending TPM20 PCRs\n",
>> +			SL_ERROR_TPM_EXTEND);
>> +}
>> +
>> +static void slaunch_tpm12_extend(struct tpm_chip *tpm, void __iomem *txt)
>> +{
>> +	struct tpm12_event_log_header *event_header;
>> +	struct tcg_pcr_event *event;
>> +	struct tpm_digest digest;
>> +	int start = 0, end = 0;
>> +	int size, ret;
>> +
>> +	event_header = (struct tpm12_event_log_header *)sl_evtlog.addr;
>> +	event = (struct tcg_pcr_event *)((u8 *)event_header +
>> +				sizeof(struct tpm12_event_log_header));
>> +
>> +	while ((void  *)event < sl_evtlog.addr + event_header->next_event_offset) {
>> +		size = sizeof(struct tcg_pcr_event) + event->event_size;
>> +
>> +		/*
>> +		 * Marker events indicate where the Secure Launch early stub
>> +		 * started and ended adding post launch events.
>> +		 */
>> +		if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
>> +			end = 1;
>> +			break;
>> +		} else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
>> +			start = 1;
>> +			goto next;
>> +		}
>> +
>> +		if (start) {
>> +			memset(&digest.digest[0], 0, TPM_MAX_DIGEST_SIZE);
>> +			digest.alg_id = TPM_ALG_SHA1;
>> +			memcpy(&digest.digest[0], &event->digest[0],
>> +			       SHA1_DIGEST_SIZE);
>> +
>> +			ret = tpm_pcr_extend(tpm, event->pcr_idx, &digest);
>> +			if (ret) {
>> +				pr_err("Error extending TPM12 PCR, result: %d\n", ret);
>> +				slaunch_txt_reset(txt,
>> +					"Failed to extend TPM12 PCR\n",
>> +					SL_ERROR_TPM_EXTEND);
>> +			}
>> +		}
>> +
>> +next:
>> +		event = (struct tcg_pcr_event *)((u8 *)event + size);
>> +	}
>> +
>> +	if (!start || !end)
>> +		slaunch_txt_reset(txt,
>> +			"Missing start or end events for extending TPM12 PCRs\n",
>> +			SL_ERROR_TPM_EXTEND);
>> +}
>> +
>> +static void slaunch_pcr_extend(void __iomem *txt)
>> +{
>> +	struct tpm_chip *tpm;
>> +
>> +	tpm = tpm_default_chip();
>> +	if (!tpm)
>> +		slaunch_txt_reset(txt,
>> +			"Could not get default TPM chip\n",
>> +			SL_ERROR_TPM_INIT);
>> +	if (evtlog20)
>> +		slaunch_tpm20_extend(tpm, txt);
>> +	else
>> +		slaunch_tpm12_extend(tpm, txt);
>> +}
>> +
>> +static int __init slaunch_module_init(void)
>> +{
>> +	void __iomem *txt;
>> +
>> +	/* Check to see if Secure Launch happened */
>> +	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) !=
>> +	    (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT))
>> +		return 0;
>> +
>> +	txt = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
>> +		      PAGE_SIZE);
>> +	if (!txt)
>> +		panic("Error ioremap of TXT priv registers\n");
>> +
>> +	/* Only Intel TXT is supported at this point */
>> +	slaunch_intel_evtlog(txt);
>> +
>> +	slaunch_pcr_extend(txt);
>> +
>> +	iounmap(txt);
> 
> I would remove the empty lines in-between the three calls above.
> 
>> +
>> +	return slaunch_expose_securityfs();
>> +}
>> +
>> +static void __exit slaunch_module_exit(void)
>> +{
>> +	slaunch_teardown_securityfs();
>> +}
>> +
>> +late_initcall(slaunch_module_init);
>> +
> 
> I would remove this empty line.
> 
>> +__exitcall(slaunch_module_exit);
>> -- 
>> 1.8.3.1
> 
> 
> BR, Jarkko

