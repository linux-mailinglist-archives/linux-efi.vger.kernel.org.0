Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E135C24A1D4
	for <lists+linux-efi@lfdr.de>; Wed, 19 Aug 2020 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgHSOgy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Aug 2020 10:36:54 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:29190 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727018AbgHSOgx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Aug 2020 10:36:53 -0400
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07JEV5TL009552;
        Wed, 19 Aug 2020 14:36:42 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 3304mkfhff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Aug 2020 14:36:42 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 7FA41AE;
        Wed, 19 Aug 2020 14:36:41 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 201855)
        id 19608200FDA48; Wed, 19 Aug 2020 09:36:41 -0500 (CDT)
From:   Alex Kluver <alex.kluver@hpe.com>
To:     linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ardb@kernel.org, mchehab@kernel.org, bp@alien8.de,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        kluveralex@gmail.com, Alex Kluver <alex.kluver@hpe.com>
Subject: [PATCH v2 0/2] UEFI v2.8 Memory Error Record Updates
Date:   Wed, 19 Aug 2020 09:35:42 -0500
Message-Id: <20200819143544.155096-1-alex.kluver@hpe.com>
X-Mailer: git-send-email 2.12.3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_07:2020-08-19,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=567 spamscore=0 clxscore=1011
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008190128
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The UEFI Specification v2.8, Table 299, Memory Error Record has
several changes from previous versions. Bits 18 through 21 have been
added to the memory validation bits to include an extended version
of row, an option to print bank address and group separately, and chip id.
These patches implement bits 18 through 21 into the Memory Error Record.

Change reserved field to extended field in cper_sec_mem_err structure
and added the extended field to the cper_mem_err_compact structure.

Print correct versions of row, bank, and chip ID.
---
v1 -> v2:
   * Add static inline cper_get_mem_extension to make
     it more readable, as suggested by Borislav Petkov

   * Add second patch for bank field, bank group, and chip id.
---
Alex Kluver (2):
  edac,ghes,cper: Add Row Extension to Memory Error Record
  cper,edac,efi: Memory Error Record: bank group/address and chip id

 drivers/edac/ghes_edac.c    | 17 +++++++++++++++--
 drivers/firmware/efi/cper.c | 18 ++++++++++++++++--
 include/linux/cper.h        | 24 ++++++++++++++++++++++--
 3 files changed, 53 insertions(+), 6 deletions(-)

-- 
2.26.2

