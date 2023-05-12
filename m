Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC89E7007C7
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 14:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbjELMZ1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 08:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240928AbjELMZW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 08:25:22 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E13413C3F;
        Fri, 12 May 2023 05:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1683894299;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UmsEamxoc0B1TyBlzn36bzSgEOHu5n79eY42u9u1d7s=;
  b=K5v65wr9UXE9N4FCzt+jdp+k8awOC7dWPAd5Qtzs5PMfoNSqYwC5lLsD
   setu2I5gQjO5p/whYu318RorPXh679Yo1RAZi8avoUrMfOTpg77VJ4xCs
   dWS5BwIq3dN1LgUQKA4VSh4FJaFFMyRGpLQ1GBiyzFFQsbvErxsfWp6iN
   E=;
X-IronPort-RemoteIP: 104.47.59.172
X-IronPort-MID: 111265528
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:qv4ZUq92haV/uTv/sqR4DrUDl3mTJUtcMsCJ2f8bNWPcYEJGY0x3y
 jAfUGGCMqqLZ2qkc49yPIy09R8HvJfSmtZkGQtprXg8E34SpcT7XtnIdU2Y0wF+jCHgZBk+s
 5hBMImowOQcFCK0SsKFa+C5xZVE/fjUAOG6UKicYXoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqojUNUTNNwRcawr40Ire7kI+1BjOkGlA5AdmOKkR5AW2e0Q9V/rzG4ngdxMUfaEMdgKKb
 76r5K20+Grf4yAsBruN+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nQVVWk120c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDkle+
 NUiGG0nNizbuPqGwaCJT8J+meU8eZyD0IM34hmMzBn/JNN/G9XvZvuP4tVVmjAtmspJAPDSI
 dIDbiZiZwjBZBsJPUoLDJU5n6GjgXyXnz9w8QrJ4/ZopTWCilUuitABM/KMEjCObexTklyVu
 STt+GPhDwtBHNee1SCE4jSngeqncSbTAdtLTuPlq6Q66LGV7lALIzpOUGKendTniWyPfuBQD
 X0Q3wN7+MDe82TuFLERRSaQqWSItDYfVsBWHul87xuCooLS4hiUCmkYRxZIbMEj8so3WXon2
 kLht9f0GTtHubicQnuF96udqXW0NDR9BU0LYCIfCyEC/8XkpYU+nzrPR9B4Haith8fpHzzq2
 DCLtG41gLB7pc4T3o2p7EzAmXSnoZ2hZgQtzgzTX2+jvkV1aeaNYo2u5l/z9/tMLI+FCFKGu
 RAsh8ea/MgKDJeQiDaKRuQdWr2kj96JKCbZgEJvN5A5+i6x5mW4eoRN/DB5IlwvOcEBERftY
 UnOqUZc6p57InSnd+l0bpi3BsBsyrLvffzmW+DZZfJKY4Ntb0mG+i90bEKd1myrl1Ij+Yk+P
 pKebO6oDG0GEuJjzTyrV6IT1qItyikixGTVA5fhwHyP1buYeW7QQq0UKEeJRv424bnCowjP9
 dtbccyQxH13VOz4fzmS/YkYBU4FIGJ9Bp3srcFTMOmZLWJOHGAnFu+UwLU9doN/nrhEvvnH8
 2v7WUJCzlf7w3rdJm2ieiA9QLDiR5ByqTQ8JyNEFVKp3WUzJIWi9qESc7MpcrQ9su9u1/h5S
 78CYcroKu5IUS+B4zQcaZjlt4tkXBOxjAmKMmyuZz1XV5NqRgPG98X/Vgji7i8DCmywr8RWi
 7ii2V6KaYEZTAokEc3fbbSo1VzZlXsUnv5yGUTIK8VJcUfx2I9wIif1g7k8JMRkAQnZyz2R1
 wyRBgtdqeTTrosd/97OiqSJoJ2uDvNlWEFdGgHmAa2eMCDb+i+vxNFGWePRJzTFDjqrouOle
 PlfyOz6PLsfhlFWvoFgErFti6Uj+9/ooLwcxQNhdJnWU2mW5npbCiHu9aFyWmdln+8xVdeeM
 q5XxuRnBA==
IronPort-HdrOrdr: A9a23:RGj2RaOxvZvjZsBcT1T155DYdb4zR+YMi2TDiHoddfUFSKalfp
 6V98jzjSWE8wr4WBkb6LO90dq7MAnhHP9OkMIs1NKZMDUO11HYS72KgbGC/9SkIVyHygc/79
 YrT0EdMqyXMbESt6+Tj2eF+pQbsaC6GcuT9IXjJgJWPGVXgtZbnmJE42igcnFedU1jP94UBZ
 Cc7s1Iq36LYnIMdPm2AXEDQqzqu8DLvIiOW29LOzcXrC21yR+44r/zFBaVmj0EVSlU/Lsk+W
 /Z1yTk+6SYte2hwBO07R6d030Woqqu9jJwPr3NtiEnEESutu+cXvUhZ1TNhkF2nAjl0idWrD
 CFmWZdAy000QKdQoj9m2qS5+HtvQxelEPK2BuWh2Durtf+Qy9/A81dhZhBeh+c8EY4uspguZ
 g7qV5xmqAneS8oph6NkOTgRlVvjA65sHAimekcgzhWVpYfcqZYqcga8FlOGJkNESrm4MR/ed
 MeRP309bJTaxeXfnrZtm5gzJilWWkyBA6PRgwHttaO2zZbkXhlxw8TxdAZnH0H6JUhIqM0rt
 jsI+BtjvVDX8UWZaVyCKMIRta2EHXERVbWPGebMT3cZdQ60rL22uzKCZkOlZKXkcYzveoPcb
 z6ISNliVI=
X-Talos-CUID: =?us-ascii?q?9a23=3AHmGGtWtEoXuRrUYd+ehBrp9W6Is1f1Tn/Cr6e3P?=
 =?us-ascii?q?gNn5ZSa+nTHSC54J7xp8=3D?=
X-Talos-MUID: 9a23:Khd7egqjlmEd9HBGXOEezw16H+Aw5p2LNG1Tkrc3nvuLEx10Hh7I2Q==
X-IronPort-AV: E=Sophos;i="5.99,269,1677560400"; 
   d="scan'208";a="111265528"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 May 2023 08:24:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mwv2QhtLbOsbsbSScyTnTcTu5Py9mAvtO1S4bjagXBNZ8lrUEbTg7wYDTL8m8uoaBg2iftqyO0KzyevJBcwjtWWFjVqnR0xEfrNI6ZAPveYP6haQ0TD+fIYt4VmDs+c1xPFRsC5AGVF7EKc+wtoLU00NWprcbkpPpRrgg8DwYSPf9v3yrMHAY4+SSiWrP9xkETet8djRvH6vpu+3sNsVHIdcNdb/TJ14ESVmXNgux0+rL02rN9M+FwslKJM049oxs0iAO02W3mh5WV1M5WsezDh5n0QkqKDCNlP7FT0HoqP0EAqixVvPT6IDgo8G0NfT7gYbhb1SovfaI+nR4B60CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AOCv6rjmFmUyxkqUQ3e61ak3IqWeoqc1+8UjjvCA7U=;
 b=LY9elv8jRZIeXwiXWfODG5lbATt3pKFchDhqb34YLnao2AC35SAT2q5nSZASEQ9AS422aUCOw8P+MEjt/MAcWXAeEo6akDFrd5Ox00ueO5fMvdSivXxlfogQ3FoNFN5oWUmvD8LwwfsZxrVs1a8os0aYUlDWO8XtOf9DJ2pdvWB8SWGMUyjX6N7uL04la9EKrUFHNuxBfZDLBYQbAefJDOo3Nxvk9u89hblLJrMvaT4e/l+7KFP3Z36h2H+7PIcX2rRCBaQrqRM8cCPAT54ukTNLWIxsXx/QUTPwuArcyt6q0130ikrULeU0dyC0FuskbcB9aqWP/Pyjw5Jecb+miQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AOCv6rjmFmUyxkqUQ3e61ak3IqWeoqc1+8UjjvCA7U=;
 b=QA9hsk4ICGdTBqdLSrnmuTFtYhV9QhdvWEf/f9nMQd2itFNFGESbq+u+JhzEcCLRedDMx3/7BH8TCLeNvzbcqbB6eDUjNXuis8SVa6kKlQqYjAqJYZSe3nKeuUujbpVwjPmW8aqKtiQvM+9WuLmOAIlrtR0BVoBPq3MKhldfLfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DS7PR03MB5416.namprd03.prod.outlook.com (2603:10b6:5:2c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 12:24:31 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::4fc:e616:1cf0:57bb]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::4fc:e616:1cf0:57bb%4]) with mapi id 15.20.6363.033; Fri, 12 May 2023
 12:24:31 +0000
Message-ID: <4acf414e-67e7-c964-566b-a5e657e9d1bb@citrix.com>
Date:   Fri, 12 May 2023 13:24:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 06/14] x86: Add early SHA support for Secure Launch
 early measurements
Content-Language: en-GB
To:     Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, James.Bottomley@hansenpartnership.com,
        luto@amacapital.net, nivedita@alum.mit.edu,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-7-ross.philipson@oracle.com>
 <20230510012144.GA1851@quark.localdomain>
 <20230512110455.GD14461@srcf.ucam.org>
 <CAMj1kXE8m5jCH3vW54ys=dE2-Vf_gnnueR6_g4Rq-LSJ5BqRjA@mail.gmail.com>
 <20230512112847.GF14461@srcf.ucam.org>
 <CAMj1kXFUDUbH4avVs37uLkS=BfSFB1F60e5Ei5_m2aWxOYOGPw@mail.gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <CAMj1kXFUDUbH4avVs37uLkS=BfSFB1F60e5Ei5_m2aWxOYOGPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0063.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::27) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|DS7PR03MB5416:EE_
X-MS-Office365-Filtering-Correlation-Id: d11d132f-9ea7-43bc-4013-08db52e3d628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RIWKTKYLglULnAJF2lE/iGKiHSRYsqJujzewL5823MtgyRxh6T4eNiQ0ByhxdN3hNzzLR+eTAW/SrkkawXys+gI6Wk00vklvdRHywmiTkSj4KWOjRnMM3k+O662+eQj+GUObjBV9K10WMEt3Mvq3Kw8KrrHKVJWk6DNzGluZaSDt04bLKqlsoK1/YvjA1fYQWkRN9ytdN7pScYX99k+AI4vW0iluYuY+hvyyFCP6QGmk/j0TAvxNif1z3T1IdtgwBp72/ycS8cUrXHzrgPPvIE0j9lJ+pkELjWuub0m9/DR118yLRhGlfwW23h8azhJodkxfP+CiCT+pW315V1XMRNe92vP0fUxKOttWplEaza6s4a7R+FmRYywukZO5mMhSXyV0gWeYU1YHbeVIuRetafYfzEVgTbfPimI081TENuDQMRPPPQinpiQh8RXFwZH3eGClSKroF6vXw26R/94/nxGXIqKO30KtsAPUOb4NLm+Dpm/3Sa45C+QpXUEJm1MIBR1UQCq+/XCGrWZW4+HsYZi6jf4Ls5uhdnCvIKjdcd7cukAl+pqsJBqCsfqDrMa4h5r1unUltChaM/ircZ11mzfAwmuO/K3vcaIf7kIMvm6jiL0iKl4r1tIHtKpGe2gt1zFy5+XIHWdo4zCMsTyHGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199021)(6486002)(6666004)(66556008)(4326008)(36756003)(54906003)(110136005)(66476007)(82960400001)(2906002)(7416002)(31696002)(41300700001)(38100700002)(8936002)(86362001)(5660300002)(316002)(66946007)(8676002)(31686004)(66899021)(478600001)(6512007)(53546011)(6506007)(186003)(2616005)(83380400001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THR0TVk5RnBXTTYwVFQ4M2YvSTVyeGdTS0FtZ2YvbGRMb2xXbTBSMW9yRGtD?=
 =?utf-8?B?NzZNUng5N0ZOc0VWY2JwUGhJb2ZGb3FGV2dkWWNoWEhBWTY1R1VJV2tLM1g2?=
 =?utf-8?B?UFZrNU01TzUxeDM2SmJHTEZDeEtoZjk4WitJZGRiKzlTVjBhNWpoSjAxVnBq?=
 =?utf-8?B?YVdZaEdlR2tpN1puOWNIalpmK1dzalpaMzg2b004TDdaUG5WNWkzaXZFVk9q?=
 =?utf-8?B?TzhaL0NtSElZWFJlSURFQWdtc002S3JUS1A4QUhXNTEwLzZ6SytuZU9kaHhu?=
 =?utf-8?B?citTTlZPaXBmOXpaWWptNHIwQ1RDajN6OHA4TmxzOGs2QjRmTFBjL0w3UnpN?=
 =?utf-8?B?RnJ3eERjTGZWSGVBL3QzbHArTFA5aVdtclJRV2FialBsdDVybWVGOUppSVMv?=
 =?utf-8?B?aGs2OStmOXJnS1hXNGlrRzlJRzEwVXE5SmROS0Z1ZGpFOXBWNW8yeFhIMHR2?=
 =?utf-8?B?RmdKWVVjeGQ0MTRDSi8yQ3lRWEIzNUxFdVp6T3QwdGMzaVVYYk1qWlJ2L3ky?=
 =?utf-8?B?b0JZTTFVU3NHcWxqOGxVOGVDU0ZBYmIvUkRVM1JPM09tUzFNR0thMTc3cVN1?=
 =?utf-8?B?NG1OY3N2RzFDeEE4bms0NE03azk5ZUpFTlpjczBEM1AxVS9iOHRjaFl3QjVa?=
 =?utf-8?B?dm9rYlAxblRjT2tSTFloZWFuaXVBcWxtQUhTblZiRkZFV0J2N1cwYWw3R3BL?=
 =?utf-8?B?SjgxblRkZUczeFliaVpFek5seDRjMXRVNytkUlNuNTBldEF2ZWc3SVQ1YzFn?=
 =?utf-8?B?bkR6WU1vWFd3ZnFLcTRiMEV6M3MxUStFYmZNblZvcDUzTzQ2NGtXSVRISk5x?=
 =?utf-8?B?cmhFYUU0RVh6cUpoVVk2am51dFVXalNGYlVEcVdhaVI1Zm4vZHZtbDBDT2Yz?=
 =?utf-8?B?LzJ6SlFINGE1THF0RE1HMnpVN3Z5ZHFjbDNBcDlrV0VXdnBmci9va2hMdmMz?=
 =?utf-8?B?N3kvMERiQTJEa2xSYjB5SlM5WXpXY1VxRWJlSXVoWWdHMmtZRnFGNzBCenpy?=
 =?utf-8?B?RG5lRE1vc1JYVzRuOXAwUTArWXlISGVNcWlHY2s2eE94YjROZFloNnB5RThY?=
 =?utf-8?B?MUNlNUZuc2VrWDNTQmd4UHdxaVlraS81Vjd5REFjUlYrVElENExjajgrR2xi?=
 =?utf-8?B?U3pqOVBSeXUyVHlIRlJsaXRNNlE1ODUwaTdhbms2czdvaWRYNFhjQTE2VDEv?=
 =?utf-8?B?ZEVHWHp4Z0NlNkgvdGFQdmtFRXpsWVBkWjJiK3EzK1VYV2pwQVpPdkdBRkt2?=
 =?utf-8?B?NnFLMGdtR3BzdXZvSzJpeDBpcW1aVUt6VHQyeVErb015TjN4UDdtUlFzSzhU?=
 =?utf-8?B?Tm82NWFZdjN1ek80UURwL0t6dWMvejk2YlRPSUV2UUxuZDdDZFBnb1BrK3pZ?=
 =?utf-8?B?RTcxakNMRDd2TTYvNjNLSFVZOWhJUlJ6SEUrWTBVTFIxOGxuV0VOa00yMkpS?=
 =?utf-8?B?NVAxRUFTYzlBWE5LQStsb3psSUhOZTZTdHJjSG9HNG5Ebmhjeko3d1ZDOGhs?=
 =?utf-8?B?MkUwNEJnd0xCUmdOUzIwT3hwMXZPTm1IUkQvSHhnT3ZZMXhMRkV5OFFwLy96?=
 =?utf-8?B?VnRBZVFSNUE0YmVEK2tEY1ZtUDMrTjc3NWtSdEVWS1hOTVpZL2FvWFZEbEJs?=
 =?utf-8?B?VUgrTTd6TTZYdWttOHJPQ2hFOVluY1RKbEpoN3VYWjlRMzJFb3lGTDhTV056?=
 =?utf-8?B?RE9sRHNNa2hBQ0JwTlNHbER5b05DdlQ4SnFYQVdlK1oveGRiN21KYXUrVzVo?=
 =?utf-8?B?YUdkdjhaSjZQNy9JcXQrV0t6VFM1NmkwZkw3L21lOTFVTURmckpIYW14ZmRX?=
 =?utf-8?B?SG00dmtadWpwMjc0QWR1Nm8zVWZ5aEpSS05PSWNPdGQ1SERTaEM1RHYySld5?=
 =?utf-8?B?ZEUvR0xFZUhiUDVDYWdOY3JOb1VRRGg4d3had1p4Ri81ZnE4Z2FrNkExNVkz?=
 =?utf-8?B?dzlPdFhkR1ZpYmNoRWFINDB3cTRJN2FkcnlpMW5ZbXpsSytGU2VqMDZsWmJY?=
 =?utf-8?B?eXowYVRsUmV0L0ZJeFVreUNudEJ6VkY1T1drWFVwdEVrMXM3YTBHUjhxNDNw?=
 =?utf-8?B?bUhrZnJUZE01Q0ZvK01zVEY4QWJPZkNpbGtOYk1tNjZJRThrSk40c2NVZmp2?=
 =?utf-8?B?dk10bUpXSDljbm9jaGo0RFNHc0xuL3gwcnlMbUk0WTdYbTlJL3BESmVLUGJa?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RFpiTjJmSzdZR3FOZVJIVUFtaXRYVHNLZ0RJWDhRWWRINjdGeURDTXI4c1dF?=
 =?utf-8?B?TkZ4WWluemw3dERvYXdOYkFNTFhnVlB1UHhTZEFmN01hUmhWRFd0Y240VUcw?=
 =?utf-8?B?NWNTeGZ0R2FLZWRQVS9WRDcyYkYySmh4SGNsb0x0VmF1Z3hOSTJzWFdlU1M1?=
 =?utf-8?B?VzRXNUNrRElLb1lIRnhEdW5TUTg4djV6STFQYktuU0dzN2N6Yy9KSjgwZElH?=
 =?utf-8?B?YTMwaXhYNjZ1dzdWOWlzb0JjdnVlZmN0K2tRRmk4RVg5VkJlb1MvK1NiZHJB?=
 =?utf-8?B?ME9BWGZkd1R1T05wclhKNndkZlI5ZjJ2YXVLU2UvVFF1N3lHdngvOUFSK1Fl?=
 =?utf-8?B?aUZRbDRlZEpOVEZCQ21kQjJIYS9WMFVja0Nob05ROHRlWlJWY29GZkk2SWhl?=
 =?utf-8?B?VXhwVmNhRjBGNk0waVMzN2VhekhLQ250RlJhK1BtcUFlNEpTbnp2ak01U2gw?=
 =?utf-8?B?dUl3bHJZUTVVMi84K1czcVBJNFErbUxqVUUzNXpJY2xiSEtqaUkxelczVVY3?=
 =?utf-8?B?Y00yV254eWdsdEtNUnp6ZXh3RmlHTHljaFpmbkFVK2lTdWRSTFBYcjhhNllV?=
 =?utf-8?B?TVFFRTBTY1hpZVV0SmFVclFOVUdYY0ptMjIzUERCc3VxcnhreHRuTTZuWmhI?=
 =?utf-8?B?dzd5Rlhxd0JNQURUUi96ZUFWYmFoaTF0MEVNSG5VT3NEYmdBb0xvL3dBZ0t3?=
 =?utf-8?B?dE1nRi9ObmhwWDRnQUdDNktNeFJxc21nZHNnaDJ1Qm1kK0l2R0NsU2IxcTQx?=
 =?utf-8?B?bFlKVUl1QjhtRVVlOEkrYjArMS8xR0k5Zlp0emJIdVlMbWEvNU5CUW9kdWpl?=
 =?utf-8?B?L1RkalljRnhsME1HYWFCNExhM0Q0Rm0xYmt1TTNqUEZaMGhOcXkvRnVESmRt?=
 =?utf-8?B?K2d1SlBvWWcxRWdWR0lUeXJFZEhSRkZtTEF1MDFGUWNMRTQ4RnlBdExCcGFH?=
 =?utf-8?B?WXdFWkhPaU00K2g4cVczcm9IVHBjTWw5b2dXRnovQUJNVjFGVWdIYmZOR0Fz?=
 =?utf-8?B?bE4yN0lCWGdVNG84eFlkT1ZJSDFkOWtFSmNLM3daaXNBOVJwaHpNWXJZUHBO?=
 =?utf-8?B?OXVXVEExL3hHNEh2dnYxNDZKcElKTUtRTHJNNURRbStyaVVtOVJvMXU5T2hP?=
 =?utf-8?B?TnhERHNBeTNiQmFNaEtsUTRzUjZDcGpIcXNFYWE2c2txeHc3N1pYbEFkQkh4?=
 =?utf-8?B?NzEzOTNMaE5Ec0dwdkdYU0tScG5wTTFSUXdZWHBubUxUa3VIZ1pPRUlJd2VT?=
 =?utf-8?B?akhmN0Nja0puTHU5NytRT0JQdGFjU0JaSGhDbTF2d2ZqTk1NZ05yN3ZtVStE?=
 =?utf-8?B?V0JsVFhtUDJHTEVOdXJSN2VjbUNvSGh2bkx3TkFGSUVESitmeDRScE54aC9P?=
 =?utf-8?B?MDd3YWJPTzUrdVMrRmQwbmsxWHhhZU1Ja0pSa2o2QUI5RldQMi8rb3M1QnE4?=
 =?utf-8?B?N1N0dXNVU3FkNXoxcXhXYWZDNFBoQlNGSVREbXlUUDVWbTVrYmZHYitoWEQ2?=
 =?utf-8?B?UDhTbW9pQTN1d0FiS3NCWHdqeklmNkRqNFVHQmpXcWQzZm1POXpLMitybThx?=
 =?utf-8?B?dklzNTFBeFZnWndzOUo3cm5Uak9kSmRxTUsrbDU4ZTdydy9UWGVaUWtrR0Na?=
 =?utf-8?B?YXZ2WnIyaXhwOFg3QWlVVjhyV1pTTWZ0TUh4OU82czIvYWVRcU9kQmFFUmFT?=
 =?utf-8?B?aGZicE11dTVRUEZHWDRKSnk2d3JGMEhITVI3VEhOL0tOUGpuajhpYVVJY1pn?=
 =?utf-8?B?VHl5akhqdjI3UUc4cjBmKzZtQnpnODRIY2xWeDVIYkFDZ0Z2V0NIb0cxVDho?=
 =?utf-8?B?aUZ4b1Y3RFJKYUt0ei9YZz09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11d132f-9ea7-43bc-4013-08db52e3d628
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 12:24:31.0223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dg1dsbT/WVUuAyF0QmBy8LiiJpii/+psWFmdrQb/xQDke4NjX1UBR4bf/IDrncyFece0hlsCIzZcWngzlh2N7yH+eE5+sNZaq1GpFJ5X6cY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5416
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/05/2023 12:58 pm, Ard Biesheuvel wrote:
> On Fri, 12 May 2023 at 13:28, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>> On Fri, May 12, 2023 at 01:18:45PM +0200, Ard Biesheuvel wrote:
>>> On Fri, 12 May 2023 at 13:04, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>>>> On Tue, May 09, 2023 at 06:21:44PM -0700, Eric Biggers wrote:
>>>>
>>>>> SHA-1 is insecure.  Why are you still using SHA-1?  Don't TPMs support SHA-2
>>>>> now?
>>>> TXT is supported on some TPM 1.2 systems as well. TPM 2 systems are also
>>>> at the whim of the firmware in terms of whether the SHA-2 banks are
>>>> enabled. But even if the SHA-2 banks are enabled, if you suddenly stop
>>>> extending the SHA-1 banks, a malicious actor can later turn up and
>>>> extend whatever they want into them and present a SHA-1-only
>>>> attestation. Ideally whatever is handling that attestation should know
>>>> whether or not to expect an attestation with SHA-2, but the easiest way
>>>> to maintain security is to always extend all banks.
>>>>
>>> Wouldn't it make more sense to measure some terminating event into the
>>> SHA-1 banks instead?
>> Unless we assert that SHA-1 events are unsupported, it seems a bit odd
>> to force a policy on people who have both banks enabled. People with
>> mixed fleets are potentially going to be dealing with SHA-1 measurements
>> for a while yet, and while there's obviously a security benefit in using
>> SHA-2 instead it'd be irritating to have to maintain two attestation
>> policies.
> I understand why that matters from an operational perspective.
>
> However, we are dealing with brand new code being proposed for Linux
> mainline, and so this is our only chance to push back on this, as
> otherwise, we will have to maintain it for a very long time.
>
> IOW, D-RTM does not exist today in Linux, and it is up to us to define
> what it will look like. From that perspective, it is downright
> preposterous to even consider supporting SHA-1, given that SHA-1 by
> itself gives none of the guarantees that D-RTM aims to provide. If
> reducing your TCB is important enough to warrant switching to this
> implementation of D-RTM, surely you can upgrade your attestation
> policies as well.

You're suggesting that because Linux has been slow to take D-RTM over
the past decade, you're going to intentionally break people with older
hardware just because you don't feel like using an older algorithm?

That's about the worst possible reason to not take support.

There really are people in the world with older TPM 1.2 systems where
this D-RTM using SHA1 only is an improvement over using the incumbent tboot.

~Andrew
