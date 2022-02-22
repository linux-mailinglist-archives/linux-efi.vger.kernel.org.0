Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8865B4BF9B2
	for <lists+linux-efi@lfdr.de>; Tue, 22 Feb 2022 14:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiBVNoV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Feb 2022 08:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiBVNoU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Feb 2022 08:44:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C569411EF14;
        Tue, 22 Feb 2022 05:43:55 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MDhWDv022674;
        Tue, 22 Feb 2022 13:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=42wDX7voY/HwLK+YbIrcCBtOc36Zfb0t64NhpgUMQ3w=;
 b=Q6U5e5vRcwsOaPHvcqHT+pa7ciOFaykICdpHWWfdo53HTs4SB4/KgpYZkDC2MSRiYAm9
 g0lT/DZ3tm8mLgODEG1wtSeQKeIbE3H32qoV/37l4sdkIOgXucjhrgDErJiThMumqJg1
 gUM06IzY3KY6mpGzeTSA273Jgb+N27OcXhl2CXfyD3lhILb4MUa7jAK/nu2GneC4/YlV
 oo544cYamJSqiZqyanC8hzjDz6CIOTeVRDhq/ZM0QONaFGNr7B8dj0HzQa1tk7RQX+c/
 3D0iP2tEbIHv+qB6gDrb4mk/g2JjItdqA+ggICb1oGcc6XboHIPO8U2eYTEZZMNLFdzx lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ecxg9v01q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 13:43:34 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21MDhXpq022905;
        Tue, 22 Feb 2022 13:43:33 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ecxg9uyxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 13:43:33 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MDdgMS000828;
        Tue, 22 Feb 2022 13:43:23 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3ear6931vg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 13:43:23 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MDhLZh40567134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 13:43:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 630DEAE051;
        Tue, 22 Feb 2022 13:43:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57658AE045;
        Tue, 22 Feb 2022 13:43:19 +0000 (GMT)
Received: from sig-9-65-81-84.ibm.com (unknown [9.65.81.84])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Feb 2022 13:43:19 +0000 (GMT)
Message-ID: <5f685d7d4aa6f4253cb4b779d639bd8435dedacc.camel@linux.ibm.com>
Subject: Re: [PATCH v10 0/8] Enroll kernel keys thru MOK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org, ardb@kernel.org, jmorris@namei.org,
        serge@hallyn.com, nayna@linux.ibm.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Tue, 22 Feb 2022 08:43:18 -0500
In-Reply-To: <YhTWhcIx9B/pyiwD@iki.fi>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
         <YfFP6OHqBVNWKL2C@iki.fi> <YfFTf6vIpNMIrwH0@iki.fi>
         <78d2c13ad60b5f845cb841d257d1b41290f575c6.camel@linux.ibm.com>
         <YhKP12KEmyqyS8rj@iki.fi>
         <8e9e4bc3bbd831a606f264ec3f4dfcafdeebece6.camel@linux.ibm.com>
         <YhTWhcIx9B/pyiwD@iki.fi>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a2L47UilmZMiKGB4uGFvWuxZzD2L1YZN
X-Proofpoint-ORIG-GUID: 95iJdQevqT-1h3nV91PXwhQDiY9JQ14e
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_03,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202220078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2022-02-22 at 13:26 +0100, Jarkko Sakkinen wrote:
> This is the problem I'm encountering:
> 
> https://lore.kernel.org/keyrings/YhLNYxBTbKW62vtC@iki.fi/

Try using the Message-Id: <
20220126025834.255493-1-eric.snowberg@oracle.com>

-- 
thanks,

Mimi

