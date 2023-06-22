Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855C273A413
	for <lists+linux-efi@lfdr.de>; Thu, 22 Jun 2023 17:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjFVPAM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Jun 2023 11:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjFVO7y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Jun 2023 10:59:54 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD2A2975;
        Thu, 22 Jun 2023 07:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeXUdx+FHFEc9pp1tVfPSPuFKXC8KPW/7PHwqYOa6WgZj9HyYOSkym4VirRhoDBUuzDr+hSX22qnZeSyanSo1w+BC7S2CFwxSaAcp0H8dyCx6ZdV8zkOzziVPdH53B1PctmH1ogTxXJ4hUc3mlEIitO03Z6+c5KDq3bQzqZ2sNEpTVibos4p+AW1NdvRR/fmK4Y68g+NrrHv1wOezaF8rX1+vu6BckGQRXQfFE2tmqTkJmqCi5MI9K0bixEUMCQmO7vaEry+1QMgG2LQC7fCaAs46SaFD8mQWSCJl7V/tVYddsLmkmoz0x6MAcEUgB9vPZJa55xSqfhFMcDtxtDYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHXwQdner+ixHCqBXmeb32ZTyR1cd0K5HHdr/UO3YJk=;
 b=DeM+oRfWcsZxC7FyRCGOG1Guoy6ud2rISG1au5ReTpt7LXZHD3LzY29z1AoXiUAxgkO+aQE4yEXfzyMiwyDJ5euapXSZeWjw96EcH1XD03B6QOnyG0iyuDAUSET5eYDEpxjLw1zVugPdY8Msv/MnLL8VYCuK+HXuXiRAVT+xvXcgeaKLXiz7vTNw7cGKTWjU3MNAN9fgHBbC9RdnUJ2x/tWKPFZtqch1en63jAHR0SNO/ubK3Ir1nO7JOpx1lUTsJYBq/gclxhySObYSZLoN0ahYBp2pJQBP/yH8MVnOH4RY6jhiw1DhYmrqw+FQlMHMqFJNIWziG5LS4OgvA/UClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHXwQdner+ixHCqBXmeb32ZTyR1cd0K5HHdr/UO3YJk=;
 b=xwyMwnPIlEeu1m5bxcGE9v0ZI+HJu6fFGxo7cw1+OvdALBrZgxx2hBGr9kGMhEc6HvUEjZKeeRe6qMpp9o7W4gOR1Gl6+9WmT8JL+sKGMIeeKmJMUPYaep2xSr4qOk2eQu3H0V4xPnAEpnT9iaY38jsl5/RI8l4tEnvNpyE5qCWi5yjL+J68O4fSbT57Q+pBCFaU422N7S9zixarvk6xuiFnZccEt0z6NqEAo+acKsuyZ28+6idedhRqw2gLafm2nrBTUbjVQX51AaptEa3QLqet81xzjpyuJYyarnzan67z/5c4epgy/5PIXpEHdB2TD7mKIj6tKHbw/5f0ZLSRCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 14:58:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 14:58:53 +0000
Message-ID: <5fe03be6-8c95-0bfa-687d-68e7ddffd97c@siemens.com>
Date:   Thu, 22 Jun 2023 16:58:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 4/4] efivarfs: automatically update super block flag
Content-Language: en-US
To:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org
References: <20230622085112.1521-1-masahisa.kojima@linaro.org>
 <20230622085112.1521-5-masahisa.kojima@linaro.org>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230622085112.1521-5-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: f2dc7df4-1bc1-4154-6095-08db73313221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYgsXCY5tTLLZTIXfMeSBqUc6/zb1sSqnLLpESeMjUFWeeBC3QNeFtHvstJ5gBzGYMHbNK8ZEm6lPlm1R+1JwgmUTbw+RGpZRkiJsUCoO4abPrsdhx+elI7fglSkuQtdoH49NDYfiI2qr3UEVjG38hWnWODyvUu5r/2PYoQja4d0jNReWYS0jbUcTqg82so257C74nJMCA86KqeEIo7SjKYZ4cDs3r4JILxXQHh5rjQeO5zkJAtgZqAi4oM8ZgsRg/cUXSMgeAYxy4VWWh+nm46Zq9e5zHgU4TCWKilP36Qw55dAI9WWHpyAoC58DJUuM/hcFT9tGa0JcR3dG2uQ/rlnVDCjhHhNgYXcHS5uQMWbMv/PQ5ve0NUO2aoCVqvPGSiWgbIby+fTAJdj4/hhVcrlUcAs/+Oi8Y+Q6DlZiRlp3DxO61PqD8w72k2re2kxE/wRSEqZJ4Kx7/wGHFg+niIwpIo0JoYqT8XxzWSCGCkzZq+c+iRLvvvON0fUr+hPQfOh23dOwvvyXCnnFJQbFmHdL7Z2RKIeVOIzrOLjaGvpOXMwjSccHWzCTcn3QuJlUvjQkqJYSCkRd6jJTECpWdkMQFC/0Y9OlMRGIkeDJ3VoYw2l83i6uqVQJexiUhDcorehz2JIdm1Str/guSeZjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199021)(6486002)(38100700002)(83380400001)(186003)(53546011)(6512007)(6506007)(36756003)(2616005)(66476007)(316002)(4326008)(66556008)(66946007)(2906002)(4744005)(7416002)(8936002)(8676002)(26005)(86362001)(44832011)(31686004)(15650500001)(5660300002)(31696002)(41300700001)(54906003)(110136005)(478600001)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnNRdCsyQ2FqSW1LcjRuL1RUNWhhekc1S3NVc1Y2STRCWXBJRDV0YURQQ2Jt?=
 =?utf-8?B?MUVpWXBYRVcxSG9hM2gvOUhrdWVmOXhkcjNNK2RSWVlaR0g4bXZ3b2lEd0FL?=
 =?utf-8?B?YlE3ZnlqdmVpeEtqMmxsa3BNWVd1aHEwaTJtdm50TzF0TnpZR3NsendNb25a?=
 =?utf-8?B?UzBjTCtpUXJ0cG03S0V4VURyOHVhZDU5dXpuMkZTczdlQ2VaM0tPb1A0cGJW?=
 =?utf-8?B?ZWxmczRXNkMrTkhZV0kvajVJNVlDQ1M3ZWpqMDMzM05zVjhxSjI3NXhBanNx?=
 =?utf-8?B?TDJXUE1xYVpKdUhzZkdQdG9Kb1pHRDQxcElsY1UxTWJOWUVURlBHNURNMExo?=
 =?utf-8?B?Wi9YMkZNU2U0ZWlidHFTZExaeStNTUQ0alRJZUlRd1U2NXd3NWxkRTNUME9G?=
 =?utf-8?B?YlhKc2RoVzRkUkoyL2pVdkFISWg2OFAyREx2bStIc0s0djZ5dm5BWW1nS0dt?=
 =?utf-8?B?alFwRlpUMFB1cVdma1g2ZW1VNzBLNTA5U0w0TjNrbEJObXpVMWxYbGRKaU9B?=
 =?utf-8?B?c0E1V2U0RXpQTmVHbVJzbC8rMnptdE94bkxUZERDbVhQRU5PWG9seTVROWZm?=
 =?utf-8?B?dllRbXVKczU5WkVSelF4OUhVSWh0cmFXWGxqdjh2MmRKeUJ2NS9nVHZYUFF0?=
 =?utf-8?B?TkRVOUI4ZmM5WFJ0bno1MGo2UXlHb1JWN0FGNjdFbVlXakhHVCtmR1RJbk9k?=
 =?utf-8?B?ZGttUGxlREg3cC9PM0ZPS2RwTEdvYUFjUVZDcjFtTFB2MlZIVEhNWHFBU0lY?=
 =?utf-8?B?MWtKNDNXeTFXZjhyRUFabC91UlFSazNGY1dJMm1wekhxWHNyMUxpNkF2MjR4?=
 =?utf-8?B?U3RqdjNWZXNIVGkwZ2o1OUlqcGlTaEJkTG9ZNU04Ris3TTBWTHBJOGpUNkI0?=
 =?utf-8?B?cUNraVdzQVhtL1lYOWNYSUxuaUU4dFRhOEJPbHdQb21EdEtXcVI4czZUcHdD?=
 =?utf-8?B?YzV6SmgrVTFGYkFwNCtlMlVCOGsrU01RdlNWa0FBMjBDL2VUc1M3OGxFNEg3?=
 =?utf-8?B?NCs4dS9VT1NmVDV6bjNTMWhiNFhPbVhHN1hOWWhQaGtEWlY0aUp0TmpNNE04?=
 =?utf-8?B?b1hOWjlVQnRCQXNnRXY3OE5ndFNPV0V0YmFOd1JEb0Q5ekdCb1E1ajBPNW90?=
 =?utf-8?B?VFdMZTVsRFlCYlc5dkFwRjdhVU5Gdy9WaXExYmszNTVLS0piSGFzOVRsaWts?=
 =?utf-8?B?ME1jZ2xGeG1tYXFmWFdCbnAvbUtKcUdIMzFKc3UxaUp3a05lSTRsbEFPamxV?=
 =?utf-8?B?ckpTN2xTb3FjN0pHS3luS01zcStJcXBIY2ROY0t0b3dqanVxWTRwbEt3bWNE?=
 =?utf-8?B?cnMvWjAvV3ZsTjFZUHdaRFJpNTZmVDdlNzlVU3M2dTBpbUQxWUhmWTFPYUd2?=
 =?utf-8?B?MlNQWGUvS0FMdEsxYnNlZDNNVFIyWTdTelJobXpTMHdYV3BiSXFqSlNtbHhB?=
 =?utf-8?B?V2ZibjBDRHZybGxBcThRR1UwWjFYZHlkRkNrZnAzQkZzbmdRcU5lQmdFUXJ2?=
 =?utf-8?B?cVp4ZldEa29vYzVPNHh2NjRkOTluNGlKQXdrSXp1S3lXcnEzdHFvRTNXTGNU?=
 =?utf-8?B?SWpvTkV2dWJHMWxVelVlNklDYmsyT01LZm5JR3o1TVh4UTlXd0xZazBka0ZF?=
 =?utf-8?B?R3JUOG5KUjVLUE1QYStZQS9rZUgrbmFiNktvSTVybHo0eDVaUVRxMC9OUmdS?=
 =?utf-8?B?QnV1NDdMY1Vrb3FQd0ZDOXUyQ3JPeGc3cm15YjJPWExnU1llYUdrbVUvT3Bw?=
 =?utf-8?B?dHdodks1YWRnSllKamx1SndNQkM4OGJla2gyOHpOZkJkMXNpV0JHMGd3QnM1?=
 =?utf-8?B?VS9LNnNkeWtZdWYzRE5odlFFdHpDM05YMVhwSGd5MTZRNVNmTHp0VkxRTlNw?=
 =?utf-8?B?VTVvTy8xSFk4ZnlYM1BmYWN5djdEc2Q2VTZzQXljRkx0Tk4wMUtYeDBVQklh?=
 =?utf-8?B?MXhnRmUyanNaWE1MemVEWVZLV1UrdFZNdW9VTzJHb1ZTSmJ3N0tjZ1Jxck56?=
 =?utf-8?B?OHo3aVR6bjdMVHZHNGN1K0ZRMzZGMnBpNnBkOGp4eG5YV1lRSHJHKzE1TmU5?=
 =?utf-8?B?bEpabGhFWUgyQ2hYQjV5V1NZdEwyUTFVbnNrL3YxbWlBdW5SMDRxd0tjUEZl?=
 =?utf-8?B?dUMvVERuYUExWnFYTEpxaGdpUmV3L2ZDaFRsaWlNcU9nckJHZDdyUVEwaDBa?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2dc7df4-1bc1-4154-6095-08db73313221
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 14:58:53.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15220h7ydC8ykgyoQ0yrS0Evt3htESwemTxdjpEpgE5X24QVrEYIPbcPMkKHEaKyeuW9mSAdiBqb9f2BqCxAPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6152
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 22.06.23 10:51, Masahisa Kojima wrote:
> efivar operation is updated when the tee_stmm_efi module is probed.
> tee_stmm_efi module supports SetVariable runtime service,
> but user needs to manually remount the efivarfs as RW to enable
> the write access if the previous efivar operation does not support
> SerVariable and efivarfs is mounted as read-only.
> 
> This commit notifies the update of efivar operation to
> efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> operation supports SetVariable.

But it does not re-add it and prevents further requests to the TA (that
will only cause panics there) when the daemon terminates, does it?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

