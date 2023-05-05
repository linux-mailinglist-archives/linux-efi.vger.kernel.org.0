Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEFE6F87A9
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 19:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjEERdc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 13:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjEERdI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 13:33:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5947C3C34;
        Fri,  5 May 2023 10:33:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345EYhg9006959;
        Fri, 5 May 2023 17:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tF39HkRge9gONQRU9mkcR1odIrWYWAxORHGJxhHXQHc=;
 b=DlXPTjPXQuuIZc1/IjcHGdlnhaRm2tvEcq3NP6Qz7v1/1M87psPfxcr+taUtELIv8o3R
 1ajpxop/6Uw4ynhxNAmVfH1WvKpWRyCN77Pz5vYUd+A+MUvGB+89gSQ8Dxq+FcKu+EwM
 ybmZ8yo+7M/1+v0uR3cvMIBXcpNDwVfu0UnAq7rAotrSELDbV+9Zt0qnGWlECzuuM6g5
 f/XmE5s4lAAVF8wunrcHWZkQo4C3/nbRxdEyso1m4ZK1xY3cWEYiKB06LFqUHKmLTUyU
 Fnt2TR9gQBIlO/+jmWZmCGK9l7MT0S/LC3UOdVi5gPdD0wnUvJzmjzgjeNOkqcS0PlSG cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4aw94m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:32:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345Grext009884;
        Fri, 5 May 2023 17:32:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8span7xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:32:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6EpGY55KMo+03nmD1NwpK5+YRp8dzvQFhW9RQfm8GFseNzWR0rKa91Cj7K3Hxhtc2wxs7QM2bs6y7uNYZrR6i2G3k+bTL3mGU6znYAfb8vgyYlTduzcszoJ7QTy2waW6ihIcTZqjiUKu6yOwEJ8xg86+uFHbL4TaJkIWICLERab552jEnNQWsJovWdKdiOjxxLRlVoZLb2kOReTMy4gikJMRwsgv25C+VQ9SClxhoYNatEtPsp+t2bWW6hye+owLqijD7Acqa4FN+NFUHEnfnkUz/S0nVonlZ7VTEgELNM1ZvWwjSojd+OmZCPjCdHNUBw/mULvTOHFeQjBYkscng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tF39HkRge9gONQRU9mkcR1odIrWYWAxORHGJxhHXQHc=;
 b=OVxdt/+Do7DKQIEIOMxafEkBZs+5qEViOba6itOx7tlR42G9gbOA7kUWZUzg1ubcpxBW7wG2m9g0pEtYPHSjd8KEURM+CI0minogSAcVshPJ5HkJGH8b+EyEOpohcYPTKqnAXTjx875haRLsOjEo8nBk0p0aWRN9zWOoT4AhBAguPs5YiX+68qOpwSU9XA/lwjYlhslLOG6xnM0xCDDo7vNF/zvpSmjFiBxnvNWfKIfBs9MasziDBa0x995Q7U3q7lFscLaKi0MDFjiCLXPQGlW5fInkrexwQSZ+iUU1Pb2FGtL7gMQQCS0KHVSbwQ0QaiNuqzDDyCPpbk2NiAaNJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tF39HkRge9gONQRU9mkcR1odIrWYWAxORHGJxhHXQHc=;
 b=qy+DnTP4aHAc9CzEbA/+Dsf01JkT1N75EAVlauQ1O4zI65dAvKfB+4OpS13R23dSXqd3NzTKl/TnR89YOmPBpQ94itDNyiIHqHnj9J2pTRCBk5WtydyYpj/N/LxjCYaxjDG5BRWYCOeXcRw2B1htRWyBcuvo6PVMZgN3TVjx5Bw=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH7PR10MB5724.namprd10.prod.outlook.com (2603:10b6:510:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:32:23 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 17:32:23 +0000
Message-ID: <0183cf72-8e97-1aa6-501a-2209867fc189@oracle.com>
Date:   Fri, 5 May 2023 13:32:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 02/14] Documentation/x86: Secure Launch kernel
 documentation
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-3-ross.philipson@oracle.com>
 <ZFUsdbkulMLlU3XA@kernel.org>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <ZFUsdbkulMLlU3XA@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:610:5a::35) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|PH7PR10MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d21cd5c-3aa6-4516-4daa-08db4d8eaf76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q3EcXMctumbm5RcftytHpXWOksVfd6lt/rYzNcDmvazIwlPfphf20YFTPjxue2W4gaTIl1iv4i5GV0o3Vswd+sLZ/lT9M8sERyLdrd/sIhwtoGhOGqEDpHhIfiUo/aBPh0P7PGEY5wXc9ucPuHrqKZuuhgrq5Uz2awcbrTZB3K/RAYb+yOPDkiWdoPU2BKdCIdiaFyS9rj4q/abDTNfyhQUXoKBFg6ZS4XEQRjFW70FaSdBzKlovyrpWlOO6oEfY3vKfk5SJiY7SD685tPxkJdeKu7jIDHmPMwW6bGNXS+uMEL5VfcNMy+GeacqR1jt0vVWsktaV6ej05wW6mEVBnMqReHF9MyGe2nGE74MeWha+SZEVD3bJmVkn5wfJacU9SSoHSJWV9e6tEs3jPUUDa9Nl/n3eqCTANMAuN7kOnTrdUWwmBrRm+LeaHY872CLk2jPw9Wbuam+1vWECYmP7f9DGKv40spWfJY/2QgyZURDfLnUC+AZg9s7bDTF0xC09YwJPRP4S0JM5waSqO0U9kQTOt/Tnlf/bVZV6vt/NTbcM6uz/b1beg2ETpbSTnfDrsVjp3Ve3UgxIeYJqlbkN0wUmaXsMY1RfD8BSxxaIDlwJZ7BWEJbJ/9q5mm4aCTnCSF6HhieQJmgAk/a9eOdy0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(36756003)(31696002)(86362001)(316002)(6916009)(4326008)(478600001)(66946007)(66556008)(66476007)(6486002)(6666004)(8676002)(41300700001)(5660300002)(8936002)(2906002)(7416002)(44832011)(38100700002)(186003)(2616005)(53546011)(6506007)(6512007)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHhVd2dnU2w4NUV3UVBacEVoc3QrVkQ3SEJUZUZuTGJiZWlIWFByOXBJbTRO?=
 =?utf-8?B?bnpEVjNQOUhYQ1BFSEdnK1JEUVdKQkh6WWVaRGxXUnZYOHlKU3h6RUVlRmF2?=
 =?utf-8?B?U2x0bEdPWGp1ak13clp0eGRYbzRRUEl6eW1WeHo0WGhlZm16a2U1aEhvL21J?=
 =?utf-8?B?Z2tKaE9FZnFjZEdiY2MzUFNGMXlKb3lMUzl5ZEp3cmxPWFdQVUFxcElwc2xM?=
 =?utf-8?B?WGxKVllUeWZSTjkyV1RUcGFkOUVXem1Ja2hJRjNVRldWUk9vNFEycTlHNzRk?=
 =?utf-8?B?T1ZRNVI4cXN2SmNKeW0zRDQ1RjRHVTdPUmIwcVRGNXFIYUd0TnMvaFhlTWQx?=
 =?utf-8?B?a3k4Q2VkQUV0djVOUGpoQTN0bjJOV1Bva29KWmFIVUkxdDdTL3VvL2RyZmpY?=
 =?utf-8?B?OS8zTVRsTjZmeXVmc05YM1JuRjNGOUh2aWZCeUhobmUyQVh6L2hKeTlUN2xZ?=
 =?utf-8?B?cXhKQ2FWdUdjR0o0NzFzajFvY1FrWi82L3pSN2E4SzhOaGRLK2pJbE5OeWox?=
 =?utf-8?B?SDVnbU90Zml5eUxuNHhXZ0tuY005dU1PUTI3Qy9qbS93WU9jYVl5QWdLV0ZW?=
 =?utf-8?B?QWlpdXhmZHFqR291bHdxK2hzRlVUVFE5djc2cCtmbDRuL1FRSmhNWFBBdHZo?=
 =?utf-8?B?UisydXFQV0hnQWpKL05JYkZrdWliNC9McHZsL2NtNGpoZUZQZC96Rk9QcFJt?=
 =?utf-8?B?T0F3Q0ZPNTZEaS9QNEVSUU1qYVRlSVNLNVRKNGxUa3R4UlpCRGxkN1Q5dGpR?=
 =?utf-8?B?NWZNZDRpbWY2dTBiZkdpQkl6UUpHZUFDWHYxSnc2VGNvck5rb2JKaHkzQzla?=
 =?utf-8?B?VnltVWhPcVBkcS9SelRaaXQ5ek9Wdm1XVjF5ZEVkWlJKczU0UUw2alF0K29o?=
 =?utf-8?B?emh2QlJ5ZGxJQVFYMGhMYWN3V0owaWxDL1VONjE4cnFpckVOVVFlMW9jamZl?=
 =?utf-8?B?UU1EclNUR1ZOK2crVmF5cG9NcnhaazFocXNrWUd2SnJtWXVBYWptcVNOcC96?=
 =?utf-8?B?TjBJelF6eS9xMHFmTWcvejYzcTZNaUVTR0gxcHVJblJSQlNhUHdpN29xTlQ2?=
 =?utf-8?B?Ykl2TWJtNTVNd0NmOXVKNkdtWFcwMm9rWFUxUVFmN3FqZ2MvRVk3L0VqTnpY?=
 =?utf-8?B?c29VNTM1QUFCMmg4RXhVWlV2N2dmVERzUXpRZE51dEdtSE9MUnY5ajN5NjNs?=
 =?utf-8?B?d2FJUTRGRkdtRFpKRm9TdktQQ0hiUStrbTZ3Y1FhY3VjSklnMW9CMEFVNW84?=
 =?utf-8?B?ckpxM2F5MjRsM1dWdVdEYmRPUFYrNVdjaGovSHRXUVc4dFYrc3ZJdUxaUHly?=
 =?utf-8?B?bnYzQlNnWU82TEQ0bGFpY091VUpZMGdCbVJzNjhHZVE2NkZFRUVGejZjNGZw?=
 =?utf-8?B?TkduN1ViRUNVUHhibkIxZ0kxL2VXbXBTOWMzTEt2ZkVOMEY2NmNoN3ZQcnp2?=
 =?utf-8?B?cnIrYVo0MHgwQjZaOVdHRUw3Wlg5eGN3a0kvZFFsR004VXB1VVNYN1JLSEQx?=
 =?utf-8?B?QVh6c3I5SmlSSTIybDg5M0NFTzBXang0NS9vZG1BVmVBQmkxdzFyRjFKMTNs?=
 =?utf-8?B?MVZnRDNxeGtkaFVGR1VVYTMrOC8vaHRyb1VlUVFMZGw4aE9URUl0anRuT3N1?=
 =?utf-8?B?dGpNbmFJRkptTUZ2cmxQZVNxY1RnUk9LQjJvSlY4NG1LY3RQTGc4aFNkNFZW?=
 =?utf-8?B?ODJSeWhULyswS2RpM3JSdGVrZ3pZMmUyVysvRk50dWgrd1V5ekhKRlZvMkxY?=
 =?utf-8?B?WDFvb2I1b2NzRXQ0TE5JTHFoYVg4SWpQZmsyWmk3QkdaYVZ4UjFoT1pEeVJO?=
 =?utf-8?B?QWtabjRoWDRZMytsVkxYWGtOTXVRYnZXUzZ5dnV2d09XWDRnRjBpYlltaGxD?=
 =?utf-8?B?WE1xOEx2ODNXS1BnMS9HZk0zWkpENk5vUUFNYnNjVXF0U09QNjhUTVZ1TVJH?=
 =?utf-8?B?QVV1ODhick4zemZsakdrVDBRd0VMSlV1bE9aVVEvVkwzQW55NjQydXBHeEd5?=
 =?utf-8?B?VzhkbnB0UDRYRi9xalVpZHZEd3JpMWlDRS9MOHliU3BFQUpTNitRZXVkcHd5?=
 =?utf-8?B?TTlKU0VnS0FkWjZTUE03TnlTdjRVRUo0MmNLT21oa0lLVkJSU25xS01Ddzhk?=
 =?utf-8?B?eDg3RU0vQWpIV0prMndUQnRZaG1zdXRqT0wvcjJoTnJUUmJzSm1tb0lFa2Vt?=
 =?utf-8?Q?d1RY8iFbCO1edc1d/ywyj9Y=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VEZmYWg5NDhWYXZIaURRbkhBZVF6VUVLWlNLWkpNOFFqMnhqTjc5cjR6MjVq?=
 =?utf-8?B?UkRFWklxSmZ0UzUzdDRPTURsVjV5QzZsUW9IdzQ4VHZCQjJzeHF5TnpjRHBj?=
 =?utf-8?B?YS9GeVIzZ09qSEtQeGFKQUVobnllUnNjMjR6RzlWRlArYmlodHpkajcwbHc1?=
 =?utf-8?B?Z1MvOUY4bGtoaGpsUy9XYVF2dHBKUDZSdjZIeEVRTlZLZ3ptQTlNNk4wRWl6?=
 =?utf-8?B?dEVMUDVxN2xtaDhKWndKSE1JenhwY0xSeXhXYVZkS0pOSWFENnRiSHJZTWtX?=
 =?utf-8?B?ak41ZWMvSTNJa3dqOXh4bDRWajZvL3lhVnNXQW13OGhZQ1JpRkZNRW9yVzNC?=
 =?utf-8?B?bUhhdmZORTNLYjRDNDgyUU9oaXFDNC9URTg4eXFsT3VxanZQTEcvSzA5Q3Vn?=
 =?utf-8?B?UXlTWjZRVnh5RHF2WGN2emx3RGUrMmJmbzA4Z1hGczBHMjk2bGk5ei9haWs0?=
 =?utf-8?B?ODVWU3ZRalM4dFl3Vmh3ZjBXNnJXTGpDbVpIU1FqdCtZRXpWYmpPNDcrV3I0?=
 =?utf-8?B?VU5SVVIwZGVzU2twMUNZOWYrdGUwNy9STFprVXN0RzByaVdTSko2TTRRdXNU?=
 =?utf-8?B?cWhtUlFwbWNSRG1aN0h1bUhCb3IzZ2RrRFRWZXdiMzRLNklzMjFVQ3gzdU9B?=
 =?utf-8?B?QmxRQytoZjlaalk5RmE0Nzc2VGJodlJwMlBXYzR3clpRSDVVSDhXeGoyTVZH?=
 =?utf-8?B?a3l4RWtZdHVkekVwaG8wSW9uRnZNMXp4b0pVZ0Z2eEpNZ1hoUGFVWXBTdWU3?=
 =?utf-8?B?M0h3aEN2dEU3OFpkaXFyeFJ2M1VBRENXTUxCd0R3RXh4czFCZDdaUGpNTTVL?=
 =?utf-8?B?VUdJc0JvK3ZJUHdTbU50a3MzL24rY01IWkpwU3pzQ1JkT1A1U1JZaC92Nms1?=
 =?utf-8?B?MVRyQ0hONmNnZkFCRDg1eGFaU0Y4RkJPamkzM1M0N2pQOFFBNy9sbmpaUGJx?=
 =?utf-8?B?eGE5SXBJZ0htMDVCUE1tczcvM3Y0WC9GMktDcnF6MVF6NXkraTJ1eDJINHBw?=
 =?utf-8?B?L2hqc0NFZ25JWDg5N2l3WWlRdFdjQ3dFRE5WcnI5K2Z4UmhUSDdJRU8waDda?=
 =?utf-8?B?ZDd6dW5rbFlMcStmMnJwblZEbjdXSDk2TkY5Y3JjY3Zlb0Vqb3B3aWp1eG1u?=
 =?utf-8?B?bmpoaUdnQXVLb1QxcE1sUit0N1pyQ2o1cTlFOTYxbFRYdjVNRTVlVW5Uem9q?=
 =?utf-8?B?NExLNlZmVUZuM3hWd0d2S1Z4UE4xR2RXQ3FNYk9XaExqWFV2ckRBT09veFFO?=
 =?utf-8?B?a3haSDBnR09RN0RnNWxkZXNrUUE0WDlRb3VTQ1JkVk5tL2xnU29JSkpTV1Bu?=
 =?utf-8?B?U2U2Z2hNQSs1ekhIc2IvUjZ3ZUF4UURZLzEvd1Z0TTNGaG5ZOXRLcmlocVhF?=
 =?utf-8?B?eTdVeVpmaWRoTGlMTDhjWUsyRTg2d0N0bFBGMjBsVFdJMWNLVTZiTHZGZnNi?=
 =?utf-8?B?TDcxMCtJb28veDMvam9VcWF1aFdqMjFhL08xT1BpL0lGQ0pIcWhhdk1MRkoy?=
 =?utf-8?B?OUpNcXBpZ3lOcnFsbEMzY1VSc2VVbEkvVFIybUE5S0hSd0VDN1FVRmEyVUgv?=
 =?utf-8?B?cjRTY1Y2VGVKdmFIOGZjNHgvUTJrOXo3UFZ1eDk3ZGpzd0wvS05rV3h4T1JW?=
 =?utf-8?B?NmJLbitqOGhleVBva25GUDJQdi9YbTFrOTd2MEZBeS9nVkRqbnVGdDdxb28x?=
 =?utf-8?B?d2dkMXdtYXhzR3JldzBQbzQ1YkMrbDdkS0NZb3JyQktScitLSFQ5bzR6TzVo?=
 =?utf-8?Q?q8QIqgtoUhDNrgzAoo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d21cd5c-3aa6-4516-4daa-08db4d8eaf76
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:32:23.7250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sw4m2En/5Y6PoRGVvkGk1AjpdQHpfRAY/P4y+2HjsNIQm+SCFGhLnnNnZiUHDCfGbmfp44LYB55Kksdw8n5K112k4JaZh/KtYsoOzCpwZxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050144
X-Proofpoint-GUID: cBF2ujzDLIrMTGq1f8h4ij-fjJjG6Pq7
X-Proofpoint-ORIG-GUID: cBF2ujzDLIrMTGq1f8h4ij-fjJjG6Pq7
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/5/23 12:19, Simon Horman wrote:
> On Thu, May 04, 2023 at 02:50:11PM +0000, Ross Philipson wrote:
>> Introduce background, overview and configuration/ABI information
>> for the Secure Launch kernel feature.
>>
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> Hi Ross and Daniel,
> 
> some minor nits from my side.

All good points. We will fix those.

Thanks
Ross

> 
>> ---
>>   Documentation/security/index.rst                   |   1 +
>>   Documentation/security/launch-integrity/index.rst  |  10 +
>>   .../security/launch-integrity/principles.rst       | 313 ++++++++++++
>>   .../launch-integrity/secure_launch_details.rst     | 564 +++++++++++++++++++++
>>   .../launch-integrity/secure_launch_overview.rst    | 220 ++++++++
>>   5 files changed, 1108 insertions(+)
>>   create mode 100644 Documentation/security/launch-integrity/index.rst
>>   create mode 100644 Documentation/security/launch-integrity/principles.rst
>>   create mode 100644 Documentation/security/launch-integrity/secure_launch_details.rst
>>   create mode 100644 Documentation/security/launch-integrity/secure_launch_overview.rst
>>
>> diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
>> index 6ed8d2f..fade37e 100644
>> --- a/Documentation/security/index.rst
>> +++ b/Documentation/security/index.rst
>> @@ -18,3 +18,4 @@ Security Documentation
>>      digsig
>>      landlock
>>      secrets/index
>> +   launch-integrity/index
>> diff --git a/Documentation/security/launch-integrity/index.rst b/Documentation/security/launch-integrity/index.rst
>> new file mode 100644
>> index 0000000..28eed91d
>> --- /dev/null
>> +++ b/Documentation/security/launch-integrity/index.rst
>> @@ -0,0 +1,10 @@
> 
> I believe an SPDX tag should go at the top of each .rst file.
> 
>> +=====================================
>> +System Launch Integrity documentation
>> +=====================================
>> +
>> +.. toctree::
>> +
>> +   principles
>> +   secure_launch_overview
>> +   secure_launch_details
>> +
>> diff --git a/Documentation/security/launch-integrity/principles.rst b/Documentation/security/launch-integrity/principles.rst
>> new file mode 100644
>> index 0000000..73cf063
>> --- /dev/null
>> +++ b/Documentation/security/launch-integrity/principles.rst
>> @@ -0,0 +1,313 @@
>> +=======================
>> +System Launch Integrity
>> +=======================
>> +
>> +This document serves to establish a common understanding of what is system
>> +launch, the integrity concern for system launch, and why using a Root of Trust
>> +(RoT) from a Dynamic Launch may be desired. Through out this document
>> +terminology from the Trusted Computing Group (TCG) and National Institue for
> 
> s/Institue/Institute/
> 
> ...
> 
>> +Trust Chains
>> +============
>> +
>> +Bulding upon the understanding of security mechanisms to establish load-time
> 
> s/Bulding/Building/
> 
> ...
> 
>> diff --git a/Documentation/security/launch-integrity/secure_launch_details.rst b/Documentation/security/launch-integrity/secure_launch_details.rst
> 
> ...
> 
>> +Secure Launch Resource Table
>> +============================
>> +
>> +The Secure Launch Resource Table (SLRT) is a platform-agnostic, standard format
>> +for providing information for the pre-launch environment and to pass
>> +information to the post-launch environment. The table is populated by one or
>> +more bootloaders in the boot chain and used by Secure Launch on how to setup
>> +the environment during post-launch. The details for the SLRT are documented
>> +in the TrenchBoot Secure Launch Specifcation [3]_.
> 
> s/Specifcation/Specification/
> 
> ...

